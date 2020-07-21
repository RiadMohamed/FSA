A simple iOS app that would help the mostly flight simmers in getting the local time of the location details they enter.
The main purpose of this app is to try and use the different software tools and implement some of the software principles regarding design, implementation, agile (scrum), versioning and testing. As well as integrating 3rd party services within the app.
This app will use the Azure DevOps boards & GitHub integration, support unit testing, pipelining.

So far I've implemented and gained good amount of experience on Azure DevOps boards and implementing scrum process using Azure, GitHub linking to the work items.

Experince (so far) with:
------------------------
* Using community coding standards for Swift using SwiftLint. (Last step of project, add extensive compiling time to the build).
* Implement CoreLocation and Netowrking modules to the app.
* Project managements using Scrum (Agile) process for sprint planning and managing the backlog.
* GitHub integration with Azure DevOps baords, services and work items.
* Releases on GitHub.
* Migrate from Azure to GitHub using Zenhub plugin to apply agile methodology.
  Sprint -> Milestone. User Story -> Issue. Feature -> Epic. Release -> Group of features done.
* (Re)Use CocoaPods for UI instead of creating my own UI.
* Use CI scripts for swift when merging into dev for an added feature.

Next up:
---------
* Create a test scheme and create test cases for it.
* Starting next release, more branches to be included/created: Develop, Feature, Release.
* Push notifications.
* Use pipelines for CD.
* Update my website to include this repo.



Project Retrospection (so far):
---------------------------------
* Always pull before starting to work on something.
* Build and run after small changes to make sure everything works fine so far.
* Each Feature should contain a Refactor backlog as last PBI to clean up.
* Use branches for each feature and merge with master for releases. No edits on master.
