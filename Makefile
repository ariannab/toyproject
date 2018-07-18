GRAPH-SRC=../toradocu/src/test/resources/src/jgrapht-core-0.9.2-sources
GRAPH-BIN=../toradocu/src/test/resources/bin/jgrapht-core-0.9.2.jar
RANDOOP-BIN=libs/randoop-all-4.0.3.jar
TORADOCU-BIN=libs/toradocu-1.0-all.jar

toyexample: basic-randoop randoop-with-specs
graph: graph-specs.json

# compile toy project
bin: src/all/ResourceManager.java src/all/Resource.java
	mkdir $@
	javac src/all/* -d $@

# generate toradocu specification on toy example class
toy-specs.json: bin
	java -jar $(TORADOCU-BIN) \
		--target-class all.ResourceManager \
		--source-dir src/ \
		--class-dir bin/ \
		--randoop-specs $@

# generate toradocu specification on graph class
graph-specs.json:
	java -jar $(TORADOCU-BIN) \
		--target-class org.jgrapht.Graph \
		--source-dir $(GRAPH-SRC) \
		--class-dir $(GRAPH-BIN) \
		--randoop-specs $@

# generate tests with standard randoop
basic-randoop: bin
	java -classpath $(RANDOOP-BIN):bin \
		randoop.main.Main gentests \
		--classlist=classlist.txt \
		--junit-output-dir=$@ \
		--time-limit=30

# generate tests with randoop and toradocu specifications
randoop-with-specs: bin toy-specs.json
	java -classpath $(RANDOOP-BIN): \
		randoop.main.Main gentests \
		--classlist=classlist.txt \
		--specifications=toy-specs.json \
		--stop-on-error-test \
		--junit-output-dir=$@ \
		--time-limit=30

# remove the specification produced by toradocu and the produced test suites.
clean:
	rm -f toy-specs.json
	rm -f graph-specs.json
	rm -rf basic-randoop
	rm -rf randoop-with-specs
