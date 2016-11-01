Feature: Java Hello World
    As a software marker
    I want to be able to run hello world Java programs
    So we can offer Java as a programming language

    Scenario: User submits hello world
        Given a file named "code/user/App.java" with:
        """
        public class App {
            public static void main(String[] args) {
                System.out.println("hello world!");
            }
        }
        """
        When I run `sandboxy run`
        Then the file "results.json" should contain "hello world!"
