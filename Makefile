berks:
	bundle install

vendor: berks
	berks vendor vendor/cookbooks
	
.PHONY: vendor
