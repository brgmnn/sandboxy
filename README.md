# Sandboxy

## Templates

A template is just an ERB template that wraps a solution. It has the path:

```
templates/#{language}/#{id}.#{ext}.erb
```

For example a factorial template for a Javascript problem with the string id
`factorial` would have the path `templates/javascript/factorial.js.erb`.

The solution is inserted where `<%= @solution %>` is placed in the template.
When writing test cases, in order to score a solution automatically print to
stdout either `'<%= @id %> test passed'` for a successfully passed test, or
`'<%= @id %> test failed'` for a failed test, one per line. After the solution
is run the total number of passed and failed tests will be stored in the
results file. The `@id` variable is a random 30 digit integer generated for
each solution.

Shorthand methods for printing the test passed and failed messages are
available. Insert `<%= @pass %>` alone to print a test passed message and `<%=
fail %>` to print a test failed message.

Here is an example `factorial.js.erb`:

```
<%= @solution %>

if (factorial(6) === 720) {
    <%= @pass %>
} else {
    <%= @fail %>
}
```
