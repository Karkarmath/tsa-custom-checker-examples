sort:
	java -jar tsa-cli.jar custom-checker --fift-std ../fiftlib -o outputs/sort.sarif --checker sort_checker.fc -c Func sort.fc

storage:
	java -jar tsa-cli.jar custom-checker --fift-std ../fiftlib -o outputs/storage.sarif --checker balance_reduction_checker.fc -c Func storage.fc

wallet:
	java -jar tsa-cli.jar custom-checker --fift-std ../fiftlib -o outputs/wallet.sarif --checker balance_transfer_checker.fc -s wallet-intercontract-scheme.json -c Func wallet.fc -c Func wallet.fc
