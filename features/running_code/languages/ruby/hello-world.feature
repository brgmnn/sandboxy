Feature: Ruby Hello World
    As a software marker
    I want to be able to run hello world Ruby programs
    So we can offer Ruby as a programming language

    Scenario: User submits hello world
        Given a file named "code/user/hello_world.rb" with:
        """
        puts 'hello world!'
        """
        When I run `sandboxy run`
        Then the file "results.json" should contain "hello world!"
