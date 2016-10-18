I am a connection string url parser. I parse a url with the form:

[scheme]://[host][:port]/[database]?[query]

I do no validations on the url such as validating if the scheme, host or port are valid. I return all strings. In such way, I support many different connection strings.