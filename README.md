# Trino Overview

## Configuration

Before you can start Trino, you need to provide a set of configuration files:

- **config.properties**
- **jvm.config**
- **node.properties**
  
By default, the configuration files are expected in the etc directory inside the installation directory.

### Trino server configuration

```
coordinator=true|false
node-scheduler.include-coordinator=true|false
http-server.http.port=8080
http-server.https.port=8443
query.max-memory-per-node=1GB
discovery-server.enabled=true
discovery.uri=<http://localhost:8080>
```

### Trino node configuration

```
node.environment=demo
node.id=some-random-unique-string
node.data-dir=/var/trino/data
```

### JVM configuration

```
-server
-Xmx16G
-XX:-UseBiasedLocking
-XX:+UseG1GC
-XX:G1HeapRegionSize=32M
-XX:+ExplicitGCInvokesConcurrent
-XX:+HeapDumpOnOutOfMemoryError
-XX:+ExitOnOutOfMemoryError
-XX:ReservedCodeCacheSize=512M
-XX:PerMethodRecompilationCutoff=10000
-XX:PerBytecodeRecompilationCutoff=10000
-Djdk.nio.maxCachedBufferSize=2000000
-Djdk.attach.allowAttachSelf=true
```

### Trino logging configuration

The optional Trino logging configuration file. The default level is INFO.

- *default location: var/log*

```
io.trino=INFO
io.trino.plugin.postgresql=DEBUG
```

### Trino catalog configuration

- *default location: etc/catalog*

```
connector.name=tpch
```

> The TPC-H and the TPC-DS connector are built into Trino and provide a set of schemas to support the TPC Benchmark H (TPC-H) and the TPC Benchmark DS (TPC-DS).

### DEMO

- [Single Node](https://github.com/kayademirs/trino/tree/master/singlenode)

![singlenode_demo_architecture](/images/08_singlenode_demo_architecture.png)

- [Multi Node](https://github.com/kayademirs/trino/tree/master/multinode)

![multinode_demo_architecture](/images/03_multinode_architecture.png)
