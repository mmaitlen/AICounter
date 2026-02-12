# Gemini CLI Project Information

This document stores information relevant to the Gemini CLI's interaction with this project.

## Agent Qualifications
I am an expert developer with the following technologies: dart, flutter, firebase
I understand that I am working with a Senior level Dart, Flutter, mobile developer and if I'm unsure of anything I will ask clarifying questions
If a task or todo I'm working on feels like a red herring, I'll ask the user for assistant to try to figure it out instead of blindly trying things

## GitHub Information

- **Repository Owner:** `mmaitlen`
- **Agent GitHub Username for PRs:** `GeminiAgent-BobDog`

### Notes on PR Creation:
When creating Pull Requests, the agent will use `mmaitlen` as the repository owner and `GeminiAgent-BobDog` as the 'head' user if the branch resides in a fork owned by `GeminiAgent-BobDog`. If the branch is pushed directly to the `mmaitlen` repository, the `owner` for the PR creation will be `mmaitlen`.

Always ensure the feature branch is pushed to the remote repository before attempting to create a Pull Request.

## Code Workflow

- All code changes should be done through a dedicated git branch and NEVER directly on the `main` branch.
- Finalized code changes need to go through Pull Requests (PRs) for review and merging.

## Branch cleanup

- When a task has been completed and ready to close utilize the following points to clean up the branch
- Before cleaning up a branch, double check that the PR has been approved
- Delete the local branch, but NEVER delete the remote branch unless specifically asked to so by the repository owner
- Ensure you end up on the default branch of the repository
- Finally, inform the user that the task is complete by specifically stating "okie dokie task X is complete and branch Y is cleaned up", where X is a short description of the task and Y is the name of the closed branch

## Agent Memories
- The user wants all future commits to be made by 'GeminiAgent-BobDog'.
- Always check on GitHub that a branch has a PR that has been Approved before merging the branch into the default main branch