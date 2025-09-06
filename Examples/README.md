# Deeplink Routing Example

This project was created to show a mechanism of mapping Deeplink URLs to screens inside a sample iOS app.
Our sample iOS app has a tab controller, that is having 3 tabs - "home", "discovery" and "profile".
Home and Discovery tabs, can navigate to "workout details" screen, which can navigate to comment screen.

So all paths in the app are as follows:

- Home => Workout => Comment
- Home => Workout

- Discovery => Workout
- Discovery => Workout => Comment

- Profile
- Profile => Settings

Run the app on the simulator, open safari in the simulator and try to open any of the following links.

## Tabs

- **Home:** examplerouting://examplerouting.com/home
- **Discovery:** examplerouting://examplerouting.com/discovery
- **Profile:** examplerouting://examplerouting.com/profile

## Workout Related URLs

- **Home => Workout:** examplerouting://examplerouting.com/home/workout?workout_model=test_model
- **Discovery => Workout:** examplerouting://examplerouting.com/discovery/workout?workout_model=test_model

### With a Pop to Root

- **Home => Workout with Pop:** examplerouting://examplerouting.com/home/workout?workout_model=test_model&pop_home_to_root=true
- **Discovery => Workout with Pop:** examplerouting://examplerouting.com/discovery/workout?workout_model=test_model&pop_discovery_to_root=true

## Comment Related URLs

- **Home => Comment:** examplerouting://examplerouting.com/home/comment?comment_message=test-comment
- **Discovery => Comment:** examplerouting://examplerouting.com/discovery/comment?comment_message=test-comment
- **Discovery => Workout => Comment:** examplerouting://examplerouting.com/discovery/workout/comment?workout_model=test_model&comment_message=test-comment
- **Home => Workout => Comment:** examplerouting://examplerouting.com/home/workout/comment?workout_model=test_model&comment_message=test-comment

### Both Can Have the `pop_<tab_name>to_root=true` Query Param Added

## Settings Related URLs

- **Profile => Settings:** examplerouting://examplerouting.com/profile/settings
