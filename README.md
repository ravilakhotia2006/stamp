# Stamp

It is an authorization service used by users to request access(read permissions) on resources owned by other users. It is 
a grpc service instead of an api-only rails app.

- [Setup](#setup)
- [Design Brief](#design-brief)
- [Interface](#interface)
  - [Resource](#resource)
- [Development](#development)
  - [Environment](#environment)
  - [Compile proto to generate ruby classes](#compile-proto-to-generate-ruby-classes)
- [Dockerization](#dockerization)

### Setup

Use these commands to setup environment for raseed.
```ruby
rvm install 2.3.2
rvm gemset create stamp
rvm use 2.3.2@stamp

git clone git@github.com:ravilakhotia2006/stamp.git

cd stamp && bundle install

```
### Interface
We are using protocol buffer message format to create [grpc](https://grpc.io/docs/tutorials/basic/ruby.html) service interface.
[Protocol buffers](https://developers.google.com/protocol-buffers/) have strict type bindings and are backward compatible.

#### Resource
Request and response of respective rpc methods can be seen in [proto file](https://github.com/ravilakhotia2006/stamp/blob/master/lib/proto/resource.proto)

### Design Brief

1. User has many medical records and a medical record can have many precriptions
2. ResourMapping maintains accessing user id, resource owner id , medical record ids and the current status

Individual Api documentation is in the respective service files.

Flow for user requesting access for records:

1. Api from app/web to monolith webapp requesting access
2. monolith app to service(delegating the task to micro service)
3. check if user(resource owner) has already given permission to read to the accessing_user (via some pre defined settings on the app itself)
4. if already given access then return ‘access granted’ or return ‘access has been requested from user’
5. send async call to user(resource_owner) via push notification / sms / email requesting access.
6. user(resource_owner) responds to the request - api to monolith app
7. response delegated to service
8. response is saved and acknowledgment to user(resource_owner) is sent
9. async event from service is triggered for intimation to user(accessing_user) regarding user response.


### Development

#### Environment

apart from setup, you only need to set DATABASE_URL for the the service to work.
```ruby
  export DATABASE_URL=postgres://user:password@host:port/database_name
```

##### starting the server
```ruby
  bundle exec ruby lib/grpc_server.rb
```

This will start the server at 0.0.0.0:50052 and will be ready to accept request

#### Compile proto to generate ruby classes

```ruby
  grpc_tools_ruby_protoc -I lib/proto --ruby_out=lib/ --grpc_out=lib/ lib/proto/resource.proto
```

### Dockerization
will be updating...
