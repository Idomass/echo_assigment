# Task
Implement a layered test suite for a modified redis container.
The tests should cover changes made to the container, and functional tests to the redis app and database.
The results should compare between `redis:7-bookworm` and `redis:7-bookworm-secured`.

## Layer 1 - Container structure tests (dgoss)
Assert changes that were implemented in the dockerfile were actaully made.
Make sure file permissions, and starting and stopping the container still works.

## Layer 2 - Functional redis
Use Testcontainers + redis-py for sanity checking the container works.
Don't implement tests yourself, find existing ones online and use them to maximise coverage.

## Layer 3 - Performance
Make sure performance wasn't broken with redis-benchmark.
Results are logged for comparison only — not gated, as benchmark numbers have natural variance.
