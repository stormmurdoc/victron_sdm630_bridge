build:
	go build -o bin/sdm630-bridge sdm630-bridge.go

run:
	go run main.go

compile:
	echo "Compiling for ARM OS (Venus)"
	GOOS=linux GOARCH=arm go build -o bin/main-linux-arm/sdm630-bridge sdm630-bridge.go
