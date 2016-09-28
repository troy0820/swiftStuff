//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()
var reactstuff = "<html><head><meta charset=\"UTF-8\" /><title>Hello React</title><script src=\"https://unpkg.com/react@15.3.2/dist/react.js\"></script><script src=\"https://unpkg.com/react-dom@15.3.2/dist/react-dom.js\"></script><script src=\"https://unpkg.com/babel-core@5.8.38/browser.min.js\"></script></head>"
+ "<body><div id=\"example\"></div><script type=\"text/babel\">"

+	"var HelloWorld = React.createClass({"
+ "render: function() {"
+ "return ("
	+ "<p>"
		+ "Hello, there This is React on Swift 3.0! <br/><br/>"
		+ "It is {this.props.date.toTimeString()}"
	+ "</p>"
+ ");"
+ "}"
+ "});"

+ "setInterval(function() {"
+ "ReactDOM.render("
+ "<HelloWorld date={new Date()} />,"
+ "document.getElementById('example')"
+ ");"
+ "}, 500);"

	+ "</script>"
+ "</body>"
+ "</html>"
// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
		request, response in
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
		response.completed()
	}
)

routes.add(method: .get, uri: "/react", handler: {
	request, response in
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: "<!DOCTYPE html>\(reactstuff)")
	response.completed()
	}
)
// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

// Gather command line options and further configure the server.
// Run the server with --help to see the list of supported arguments.
// Command line arguments will supplant any of the values set above.
configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
