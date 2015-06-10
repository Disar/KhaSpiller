#!/bin/bash
haxe docs.hxml
haxelib run dox -in spiller.* -ex kha.* -i docs.xml

