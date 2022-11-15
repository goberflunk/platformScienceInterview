# Requirements

- Node (Tested with node v12.22 but other versions should work)

# Running the tests

 1. npm install
 2. npm test
	 - TAG=@main npm test
		 - Runs all tests in main.feature
	 - TAG=@errors npm test
		 - Runs all tests in errors.feature

# File structure

 - report.pdf
	 - Report of found bugs and methodologies
 - features
	 - Folder of feature files
 - step_definitions
	 - folder of step definition files
# Additional note
 - 15 of the scenarios should fail, if the bugs were fixed then these scenarios should all pass

