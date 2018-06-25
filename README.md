# net-detect

This project intends to address a gap in resource management software. Using a custom heartbeat, clients will initiate a bi-directional iPerf speed test at a specified interval. In addition, clients will also report the lan internet usage via a communication module.
Phase 1:

*iPerf server
*Port
\*Protocol

Process Flow:
	
Client:

	1. Check for config to load

	2. Create ND-INIT

	3. Send ND-INIT

	4. Wait for validation from server

	5. Save key from server to config

	6. Run speedtest

	7. Create ND-RES

	8. Send ND-RES

	9. Start scheduling loop


Server:

	1. Check for config to load

	2. Start listening loop

	3. Validate request of incoming ND-INITs

	4. Wait for speedtests

	5. Save result to DB

Default config: /etc/ndd/config

	Server: x.x.x.x

	Identity: #{hostname}

	Key: none

	BW: 

		Download: 10

		Upload: 2

	Interval: 30

NDD Socket Parameters:

	Delim: ":"

	Size: 40 Bytes

	Header: 7 Bytes

	Key: 22 Bytes

	Initialize: "ND-INIT"

	Validate: "ND-VALD"

	Speedtest: "ND-RESP"

	Break: "ND-EXIT"	

Todo:

	1. Server store result in PStore client folder

	2. Server use DB module for client data store

	3. Authenticated clients are those with files with same key in server client folder

	4. Move sockets to separate file

	5. Transition sockets to OP-CODES for shorter frame

	6. Client scheduler

	7. Move to eventmachine
