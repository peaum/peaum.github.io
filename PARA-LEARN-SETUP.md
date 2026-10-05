# Para-Learn setup

Para-Learn is a static GitHub Pages frontend backed by Firebase Authentication, Cloud Firestore, and the Gemini API. The Firebase web configuration is public client configuration, not a secret; protect user data with Authentication and Firestore rules.

## Firebase

1. Create or select a Firebase project and register a Web app.
2. Enable **Google** under Authentication → Sign-in method. Add the deployed GitHub Pages hostname to Authentication → Settings → Authorized domains. For local testing, serve this directory over `http://localhost` rather than opening the page as a `file:` URL.
3. Create a Cloud Firestore database.
4. Copy the web app's `apiKey`, `authDomain`, `projectId`, and `appId` values into `paralearn-config.js`. Do not put a Gemini API key in that file.
5. Publish the rules in [`firestore.rules`](./firestore.rules) in the Firebase console under Firestore → Rules. These rules scope each user's decks and points to their authenticated UID.

The app stores decks and points at `users/{uid}/decks/{deckId}` and `users/{uid}/points/{pointId}`. Each point stores `sourceText`, `deckId`, `interval` (days), `repetitions`, `easeFactor`, and `dueDate`.

## Gemini API key

Open Para-Learn → **AI settings** and enter a Gemini API key. The key is kept in this browser's local storage and sent to Google's Gemini API when an answer is evaluated. It is not sent to Firebase or stored with study data. Anyone with access to the same browser profile can use the saved key, so do not save it on a shared device. Remove it from AI settings to clear it from the browser. Restrict the key and review its usage in Google AI Studio.

The AI provides formative paraphrase feedback and is not a substitute for an authoritative answer key. Review feedback critically.
