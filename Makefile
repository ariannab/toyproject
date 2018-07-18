# compile toy project
bin: src/all/ResourceManager.java src/all/Resource.java
	mkdir $@
	javac src/all/* -d $@

# generate toradocu specification on toy example class
toy-specs.json: bin
	java -jar libs/toradocu-1.0-all.jar \
		--target-class all.ResourceManager \
		--source-dir src/ \
		--class-dir bin/ \
		--randoop-specs $@

# generate tests with standard randoop
basic-randoop: bin
	java -classpath libs/randoop-all-4.0.3.jar:bin \
		randoop.main.Main gentests \
		--classlist=classlist.txt \
		--junit-output-dir=$@ \
		--time-limit=30

# generate tests with randoop and toradocu specifications
randoop-with-specs: bin toy-specs.json
	java -classpath libs/randoop-all-4.0.3.jar:bin \
		randoop.main.Main gentests \
		--classlist=classlist.txt \
		--specifications=toy-specs.json \
		--stop-on-error-test \
		--junit-output-dir=$@ \
		--time-limit=30

# remove the specification produced by toradocu and the produced test suites.
clean:
	rm toy-specs.json
	rm -rf basic-randoop
	rm -rf randoop-with-specs
