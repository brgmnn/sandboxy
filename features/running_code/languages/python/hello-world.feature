Feature: Python Hello World
    As a software marker
    I want to be able to run hello world Python programs
    So we can offer Python as a programming language

    Scenario: User submits hello world
        Given a file named "code/user/hello_world.py" with:
        """
        print 'hello world!'
        """
        When I run `sandboxy run`
        Then the file "results.json" should contain "hello world!"
