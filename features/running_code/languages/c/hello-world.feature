Feature: C Hello World
    As a software marker
    I want to be able to run hello world C programs
    So we can offer C as a programming language

    Scenario: User submits hello world
        Given a file named "code/user/hello_world.c" with:
        """
        #include <stdio.h>

        int main() {
            printf("hello world!\n");
            return 0;
        }
        """
        When I run `sandboxy run`
        Then the file "results.json" should contain "hello world!"
