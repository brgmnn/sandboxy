# Sandboxy

## Templates

A template is just an ERB template that wraps a solution. It's useful for
writing language specific test cases for that solution.

```
templates/#{language}/#{slug}/run.#{ext}.erb
```

For example a factorial template for a Javascript problem with the slug
`factorial` would have the path `templates/javascript/factorial/run.js.erb`.

The solution is inserted where `<%= @solution %>` is placed in the template.
When writing test cases, in order to score a solution automatically print to
stdout either `'<%= @id %> test passed'` for a successfully passed test, or
`'<%= @id %> test failed'` for a failed test, one per line. After the solution
is run the total number of passed and failed tests will be stored in the
results file. The `@id` variable is a random 30 digit integer generated for
each solution.

