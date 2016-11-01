Feature: Javascript Hello World
    As a software marker
    I want to be able to run hello world Javascript programs
    So we can offer Javascript as a programming language

    Scenario: User submits hello world
        Given a file named "code/user/hello_world.js" with:
        """
        console.log('hello world!');
        """
        When I run `sandboxy run`
        Then the file "results.json" should contain "hello world!"
