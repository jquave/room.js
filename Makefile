MOCHA_OPTS= --compilers coffee:coffee-script
REPORTER = spec

test: test-unit test-cov

test-unit:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--reporter $(REPORTER) \
		$(MOCHA_OPTS)

test-nyan:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--reporter nyan \
		$(MOCHA_OPTS)

test-cov:
	@./node_modules/.bin/coffee -c lib
	@jscoverage lib lib-cov
	@MOO_COV=1 NODE_ENV=test ./node_modules/.bin/mocha \
		--reporter html-cov \
		$(MOCHA_OPTS) > coverage.html
	@rm lib/*.js
	@rm -rf lib-cov

.PHONY: test