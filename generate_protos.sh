#!/bin/bash

# Ensure the output directory exists
mkdir -p lib/core/proto_generated

# Add Dart's pub-cache/bin to PATH for protoc-gen-dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Generate Dart files from all .proto files in the Backend/protos directory
protoc --dart_out=lib/core/proto_generated -IBackend/protos Backend/protos/*.proto

echo "Protobuf generation complete!"
