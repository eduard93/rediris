# rediris

InterSystems IRIS based Redis server implementation (incomplete). Uses InterSystems IRIS as a persistance engine. Based on [this project](https://github.com/chekart/rediserver).

## Getting Started

It is possible to use Redis server as standalone redis installation,
however the main goal of the project is to have an in-mem lightweight Redis server using InterSystems IRIS as a persistent storage. This can be used to migrate data from Redis DBs into InterSystems IRIS.

## Compatibility

Currently redis server supports the following methods:

* Keys
  * GET, SET, DEL

These commands might also work:

* Keys
 * INCRBY, DECRBY, SCAN
* Sets
  * SADD, SPOP, SCARD
* Scripts
  * SCRIPT LOAD, EVALSHA
* Transactions:
  * MULTI, WATCH, EXEC

## Running locally

1. Install irisnative.
2. Adjust `irisdict.py` to connect to your desired instance.
3. Install this package with: `python setup.py install`
4. Start `rediris` with:

```
from rediris import run_tcp
run_tcp()
```

## Running in docker

Currently not available. TBD.

## Testing

Using any redis client:


```
import redis
r = redis.Redis(host='container_hostname', port=6379, db=0)
r.get('foo')
r.set('foo', 'bar')
r.get('foo')
r.delete('foo')
```

Check management portal to see these changes reflected there. Changes to globals from SMP/terminal/etc. would also be picked up by a redis client connection.
