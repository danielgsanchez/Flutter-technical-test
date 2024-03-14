# Technical test for WAME

This technical test consists of a football app that allows the user to pick from a set of countries contained in the football rapid-api database (https://rapidapi.com/api-sports/api/api-football) and view all the leagues from the last season. If you want more information about a league, you can choose one and see the fixtures (those that are finished and those that are not) and the standings of the selected league, with details such as matches played, wins, draws, losses, goal difference, points, or the last five match results.

## Roadmap, roadblocks and things that fell out of scope

The first thing I did was set up the structure for a Flutter app that follows the Clean Architecture pattern and SOLID design principles. This was the first roadblock since I had to learn the structure and how the different layers interacted between them, as it was my first time using this design. After watching, reading, and trying it in smaller apps, I was ready to begin. The structure is finally something like this:

```
- lib/
-   /config
-     /theme/themedata.dart
-   /core
-     /constants/constants.dart
-   /features
-     /choose_country/choose_league/fixtures_and_standing
-       /data
-         /data_sources
-         /models
-         /repository
-       /domain
-         /entities
-         /repository
-         /usecases
-       /presentation
-         /bloc
-         /pages
-         /widgets
-   injection_container.dart
-   main.dart
```

As you can see, there are currently three features that follow the same structure:
- **data:** here you can find all the files related to data management: data fetching, data modeling and data storage.
- **domain:** here you will find all the files related to entities, repositories, and use cases, encapsulating the logic of the app.
- **presentation:** here are placed the files related to the user interface and state management.

The next step in the development of this app was choosing a style and maintaining it throughout the entire app. For this, I chose to use Flutter Cards as I think they are a clean, easy, and aesthetically pleasing way of presenting information. Cards and ListTiles allow me to represent organized information the way I want it to be shown, so you will see it used in almost every screen of the application. The design was created following different already-designed apps and widgets (such as the FOOTBALL-API widgets to show fixtures or the SofaScore way of showing the information). The color chosen was green as I think it fits the main goal of the app: showing **football** data. The ThemeData is in the config folder as it is made to keep every element in the app consistent with the green theme.

## What Will We Be Using in This App?

For data, we will use Dio (https://pub.dev/packages/dio) to fetch data from the API and Flutter Cache Manager (https://pub.dev/packages/flutter_cache_manager) to easily create a cache copy so if we go offline, we can still see things we've already fetched. This will also greatly reduce the need for API calls, since the data we have is mostly static and won't change in minutes, so we can cache it for a day.

For entities, we will use equatable (https://pub.dev/packages/equatable), which will make object comparison much easier, changing how native flutter works with Object comparison. This way, if two objects have the same attributes, they'll be the same object, even if they aren't in the same place in memory.

As for presentation, we will use Cubits, BLoC's little brother (https://pub.dev/packages/flutter_bloc), which will make things easier for us when managing states. Cubits will be responsible for showing the state of the data and will affect the page presentation, showing different widgets.

## Roadblocks

- **Time**: the amount of time given was fine, but I had to deal with learning a new architecture and a new way to deal with states (I only used Provider in my past apps), so I needed to be fast. Luckily, the Cubit version of BLoC is easy to use, and I was already familiar with data modeling the information given by the API, so one thing compensated for the other. Even with this, I had to find a quick solution for caching data: making a database is like the optimal solution for this app at least, but it's time-consuming. That's why I chose to use flutter_cache_manager, which is a faster solution and works well with the app.
  - The time invested in the app is roughly 28 hours, with most of the time spent studying how to implement Clean Architecture and learning how to use Cubit. Other app features, such as working with API data or creating widgets for data presentation, are reused from previous apps or simple ways of showing data, such as the table for the standing.
  
- **Overengineering and not using reusable solutions**:  I was so focused on following the Clean Architecture as a guide instead of a way to do things that I was doing the simple things complicated. If my feature was just showing countries, then it doesn't need to be complicated; it's fine if it's simple. With this in mind, I tried to make all the necessary files as simple as possible, but I couldn't find a way to reach more abstraction to the point of, for example, using the same base for the API calls, just changing the parameters that needed a change (maybe using the retrofit package?). Even with this problem, I think I've done a fine job managing the API calls and caching.

- **Responsive design**: even if it's heavily portrait-oriented, since the data shown isn't something that takes up much space, I think it's not so bad when you use it in landscape orientation. Definitely not optimal for bigger screens such as tablets or PCs but could be easily adapted using some extra padding to make things look smaller and centered. Might be added in following versions.

## Out of Scope (But May Be Implemented)

The initial idea was to make an application that showed not only fixtures and standings for a league but also the events of the match chosen in the fixtures screen and team details and statistics when a team was tapped in the standings screen. Sadly, I ran out of time to do this, so it had to go. At least I implemented something similar to what I wanted to do with the events in the match, such as yellow/red cards, substitutions, goals... in the standings screen, with the last 5 matches showing Wins in a green circle, Loses in a red one, and Draws in a blue one.

Also, the idea was to create a multi-language app with l10n implementation. I've used this feature in other apps before, but I felt that it would require too much time and wasn't truly worth it. The app is straightforward to use, and I also lacked control over the language returned from the API, which would blow the whole point of the l10n.
