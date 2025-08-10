puzzle:
	java -jar tsa-cli.jar custom-checker --fift-std ../fiftlib -o output/puzzle.sarif --checker checker.fc \
	--scheme intercontract-scheme.json -c Tact tact.config.json Puzzle Manager -c Tact tact.config.json Puzzle IntruderLevel

puzzleFromBoc:
	java -jar tsa-cli.jar custom-checker --fift-std ../fiftlib -o output/puzzle.sarif --checker checker.fc \
	--scheme intercontract-scheme.json -c Boc output/Puzzle_Manager.code.boc -c Boc output/Puzzle_IntruderLevel.code.boc