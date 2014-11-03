Context
=====
I'm thinking about approaches to a generalized, flexible quesiton system.  This is a simple app to work through the implications of one architectual approach to that.  Expect ugly code, bad naming, poor conventions, and all the other stuff that goes into the code equivalent of a whiteboard sketch.

Setup
=====

```
bundle install
rake db:migrate
rake db:seed
rails s
```

The entry point is `/question_sets`

Architecture
=====

At a high level, I agree that questions look like a directed graph.  So one way to approach it is to encode that graph into db tables.  I did that with the following assumption:

When we have a decision about which way to go after answering a given question, the direction we pick depends only on that question.  So, considering this question set:

```
                     +-+
               +---->|C|
       +-+   +-+     +-+
       |A+-->|B|
       +-+   +-+     +-+
               +---->|D|
                     +-+
```

When a user finishes question A, they go to B.  After B, they go to either C or D.  That decision can only depend on the answer to B.  If it depends on, for example, the answer to A, then this system doesn’t work.

Anyway, the system I have in mind is something like this:

```

         +------+     +---------+
         | User +-----+ Answer  |
         +------+     |---------|
                      | - value |
                      +----+----+
                           |
                           |
   +-----------+      +----+-----------+      +---------------------+
   |QuestionSet+------+Question        |      |PossibleValue        |
   +-----------+      |----------------|      |---------------------|
                      |- format        |      |- format             |
                      |- prompt        |      |- next_question_slug |
                      |- slug          |      |- value              |
                      |- options_json  +------+                     |
                      |                |      |                     |
                      +----------------+      +---------------------+
```

`Question` represents a raw question.  When a user answers it, an Answer is created.  Questions have:
- `format`, which is something like ‘true_false’, `dropdown`, `checkbox`, etc.
- `slug`, a unique identifying string like `recent_suicide_thoughts`.
- `prompt`, the text of the question.
- `options_json`, a json-encoded pile of possible answers.  So, for a dropdown, it looks like `[‘larry’, ‘curly’, ‘moe’]`.

`PossibleValue` represents a path in the graph.  It’s what encodes the logic concerning which question comes next.  It has:
- `format`, which type of condition this is.  Possible values include ‘range’, ‘option’, ‘regex’, etc
- `value`, which contains the body of the condition.  So, for a PossibleValue of format ‘option’, this could be ‘moe’, indicating that this PossibleValue is to be used if the user entered ‘moe’ for a question.  For a PossibleValue of format ‘regex’, the value could be ‘moe|curly’, indicating that if the user’s answer matches that regex, we use this PossibleValue.
- `next_question_slug` indicates which question to go on to if this PossibleValue is matched.

So, the general flow is that when a user enters a question, we fetch all the PossibleValues for that question and look for the first one that matches the user’s answer.  We then use show the user the Question specified by that PossibleValue.  Rinse and repeat.

In this codebase, though, I've skipped the User for simplicity.  Also, I added a rudementary QuestionSet model that just has a pointer to the first question in a question graph.

———
Anyway- in the code, you can see all the relevant data structures in db/seeds.rb.  Beyond that, the only interesting logic is in the models and the answers_controller.

It’s a little hard to see the question graph just by looking at the seed data, so here’s the graph for the `icecream` question set, demonstrating splitting, rejoining, skipping, and multiple exit points:

![graph][http://i.imgur.com/4MRW9Qg.jpg]

The `tech` question set is just a straightforward `editor->language->os question path.`
