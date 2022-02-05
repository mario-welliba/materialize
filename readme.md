### Start Postgres connector

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json
```

### Check Schema Registry

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json
```

### Create new source

```SQL
CREATE SOURCE kafka_repl FROM KAFKA BROKER 'kafka:9092' TOPIC 'dbserver1.inventory.customers' KEY FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY 'http://schemaregistry:8085' VALUE FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY 'http://schemaregistry:8085' ENVELOPE DEBEZIUM UPSERT;
```

### Create View

```SQL
CREATE MATERIALIZED VIEW cnt_customer AS SELECT COUNT(*) AS cnt FROM kafka_repl;
```

### Login Postgres

```
docker-compose -f docker-compose.yaml exec postgres env PGOPTIONS="--search_path=inventory" bash -c 'psql -U $POSTGRES_USER postgres'
```

##### Create new Customer

```
insert into customers values (1005, 'Max', 'Mustermann','max.mustermann@noanswer.org');
```
