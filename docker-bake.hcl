variable "PREFIX"{
  default = "ghcr.io/sourcelair/images/v3"
}

variable "TAG"{
  default = "latest"
}

group "default"{
  targets = [
    "base",
    "tools_git",
    "tools_goreman",
    "tools_psql",
    "tools_python",
    "tools_node",
    "tools_ruby",
    "workspace",
  ]
}

target "base"{
  context = "images/v3/base"
  tags = [
    "${PREFIX}/base:${TAG}"
  ]
}

target "tools_base" {
  context = "images/v3/tools/base"
  contexts = {
    base = "target:base"
  }
  tags = [
    "${PREFIX}/tools/git:${TAG}"
  ]
}

target "tools_git" {
  context = "images/v3/tools/git"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/git:${TAG}"
  ]
}

target "tools_psql" {
  context = "images/v3/tools/psql"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/psql:${TAG}"
  ]
}

target "tools_python" {
  context = "images/v3/tools/python"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/python:${TAG}"
  ]
}

target "tools_node" {
  context = "images/v3/tools/node"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/node:${TAG}"
  ]
}

target "tools_ruby" {
  context = "images/v3/tools/ruby"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/ruby:${TAG}"
  ]
}

target "tools_gh" {
  context = "images/v3/tools/gh"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/gh:${TAG}"
  ]
}

target "tools_goreman" {
  context = "images/v3/tools/goreman"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/goreman:${TAG}"
  ]
}

target "tools_redis_cli" {
  context = "images/v3/tools/redis-cli"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/redis-cli:${TAG}"
  ]
}

target "tools_mongosh" {
  context = "images/v3/tools/mongosh"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/mongosh:${TAG}"
  ]
}

target "tools_mysqlsh" {
  context = "images/v3/tools/mysqlsh"
  contexts = {
    tools_base = "target:tools_base"
  }
  tags = [
    "${PREFIX}/tools/mysqlsh:${TAG}"
  ]
}

target "workspace" {
  context = "images/v3/workspace"
  contexts = {
    base = "target:base"
    tools_git = "target:tools_git"
    tools_gh = "target:tools_gh"
    tools_goreman = "target:tools_goreman"
    tools_mongosh = "target:tools_mongosh"
    tools_mysqlsh = "target:tools_mysqlsh"
    tools_psql = "target:tools_psql"
    tools_python = "target:tools_python"
    tools_node = "target:tools_node"
    tools_redis_cli = "target:tools_redis_cli"
    tools_ruby = "target:tools_ruby"
  }
  tags = [
    "${PREFIX}/workspace:${TAG}"
  ]
}