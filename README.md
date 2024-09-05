# Ios VIPER Architecture: TodoList App

Viper todo list is an application illustrating how to structure your ios projects in VIPER architecture
VIPER is an acronym that stands for View, Interactor, Presenter, Entity, and Router. This architecture divides the application into distinct components, each responsible for specific tasks:

This separation of concerns enhances modularity, scalability and testability.

# TodoList App

This repository contains a detailed sample app that strictly implements VIPER architecture organizeing all features in View-Interactor-Presenter-Entity-Router

<p align="center">
  <img src="https://raw.githubusercontent.com/rColeJnr/Viper-Todo-List/Main Screen.png" width="250">
  <img src="https://raw.githubusercontent.com/rColeJnr/Viper-Todo-List/Empty view.png" width="250">
  <img src="https://raw.githubusercontent.com/rColeJnr/Viper-Todo-List/Onboarding.png" width="250">
  <img src="https://raw.githubusercontent.com/rColeJnr/Viper-Todo-List/Details creen.png" width="250">
  </p>
<br>

# Features

* Onboarding
* TodoList - Shows card views of inprogress and completed todos
* TodoShowAll - Show all inprogress/completed todo
* TodoDetails - Ability to edit, mark as completed and delete todo
* TodoCreate

*The application uses the delegate system, thus taking no advantage of Async/Wait or Combine*

# Known issues
* when launching app without internet connection, after creating a new Todo the option to download dummyjson dessapears. It should show as long as the dummyJson hasn't been downloaded
*dummyjson does load on next app launch*

# Future plans
* Implement the combine framework for interaction with URLSessin and CoreData
* Add a sorting feature
<be>

## Your contribution is welcomed
Just clone the project, write some code and make a pull request!

No external libraries used

*Please make sure to update tests as appropriate*

*Don't forget to leave a star⭐️*

