ENoTime
=======

The `ENoTime` is a environment to write large, highly scalable systems in. It
provides base abstractions and concepts and makes it fast to develop new
systems. The ENoTime is a highly oppinionated framework that implements all the
common bits that have to re-implemented every time.

ENoTime makes heavy use of existing software to reduce the amount of code that
needs auditing and testing. Everything in ENoTime is written in a way that it can
be extended in any programming language as loing as that language has a minimum
set of libraries we depend on.

The basic building blocks of ENoTime are:
 - global registry
 - message queue
 - persistent data store
 - API layer
 - login handling
 - authentication and authorisation handling
 - central crypto engine
 - metrics

One of the core ideas in ENoTime is that all data is encrypted if it can't be
treated as public. This means that we have a system where data is secure at
flight and at rest. We will need some plain text meta data but we should try to
reduce the amount to a minimum. Ideally, we could have someone intercepting any
part of the system and not having anything of value to walk away with.


Global registry
---------------

The global registry is implemented in `consul` to take advantage of a already
well tested distributed data store. We can (ab)use consul for other bits in our
infrastructure where we need consistent key/value storage as well. Consul has a
DNS interface as well that may come in handy for service discovery.

Details on Consul: https://www.consul.io/

Message Queue
-------------

We have used RabbitMQ in the past and have a lot of experience running and
looking after it. RabbitMQ has been a pretty boring piece of infrastructure in
the past and boring is what we are after.

Details on RabbitMQ: http://www.rabbitmq.com/

Persitent data store
--------------------

We have used CouchDB in the past a lot and the ENoTime will be built with it as
the persistent Data store. However, I will try to abstract all the data
handling out so that it can be used with any data store in the future.

Details on CouchDB: http://couchdb.apache.org/

API layer
---------

I will use `maru` for this. Maru looks like a very nice API layer that forces
us to define what we expect as data, vlidate it and we should get in the habit
of creating our custom data types right in that layer. With `maru` we should
have a nice sanitisation layer for all incoming data and we can then hook in a
generic way into our backend.

All our incoming calls have to have a JWT and we will carry that token all the
way through the request lifetime. We will also generate a uniq ID for every
request that will help us with debugging calls and with metrics gathering. Goal
for the API layer is that it becomes a simple wiering interface where we can
wire new backend functionality to API calls by defineg the data we expect and
the endpoints in the API.

Details on `maru`: https://maru.readme.io/docs

Login handling
--------------

The login handling in a generic piece of infrastructure that is highly
repetitive but also critical to get right. The login handling in ENoTime enables
users to register, will have an account/user abstraction so that several users
can have access to one account with certain roles attached to their access. We
will have hooks for authentication email handling, password reset handling,
login notification, MFA and all the things. It will be configurable what
exactly will be offered so that we end up with a flexible system that can
easily be customised to the needs for the relevant project.

The login handler will not sore any data in plain text, this is even true for
emails. On signup the email address will be hashed, not only the password and
the downstream layers will only see the hash, never the plain email. this means
we should end up with a persistent data store that has no knowledge of the
actual users on the platform. The rest of the data for the user will be
encrypted and can only be de-crypted by the login handler or any other
authorised component of the system.

Details on the Login handler: github.com/norbu09/tashideleg

Authentication and Authorisation handling
-----------------------------------------

We use JWTs everywhere as they have the nice feature of an addd scope that we
can carry with us. All calls in the system need to have a JWT attached to it.

The API layer will check the authenticity of the request, it will have all the
checks to see if the request has a valid token, check eventual rate limits and
other bits and only let requests pass to the rest of the system that are
authenticated calls.

As all calls have a JWT attached to them we can then check the authorisation in
the worker process. The API layer needs to have no knowledge of the permissions
for the transaction the user wants to perform. The worker process, however,
needs to check if the user has permission to execute the task they want to.
This means we need no knowledge about the nature of the transaction in the API
layer. The worker is the only place that can make a call about whether a user
is allowed to execute a job or not.

Central crypto engine
---------------------

Anything crypto is hard and so many projects have gotten it wrong despite all
their best intentions. I am sure that I am guilty of this too. Knowing that I
will get it wrong I want to farm out as much of the crypto bits in ENoTime to
`vault`. The advantage is simple, `vault` is a well tested, very flexible piece
of software that implements a few very important core infrastructure pieces.

The most important in my view is the "break glass" operation where the vault
can be sealed in an instant. Also, `vault` has a way of needing more than one
person to provide codes to unseal a vault. This is important for PCI compliance
and is a good idea in general.

Vault will run on top of Consul in our setup to make the vault available in a
HA manner.

Details on `vault`: https://www.vaultproject.io

Metrics
-------

Running any slightly more complex system makes it vital to know what is going
on inside that system. ENoTime is built from the ground up to integrate nicely
with Prometheus and all code developed on top of ENoTime should be written to do
the same. With Promoetheus we have a very flexible merics engine that already
has integrations in a lot of our stack and will be easy to integrate into new
bits of code. ENoTime has abstractions for metrics gathering and will have custom
behaviours and makros that can easily be used in any code to add metrics
gathering.

To graph all those metrics we use Grafana. It is a robust graphing engine that
plays nicely with Prometheus ad has broad community support.

Details on Prometheus: https://prometheus.io/
Details on Grafana: https://grafana.com/


