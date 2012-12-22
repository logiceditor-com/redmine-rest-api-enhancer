redmine-rest-api-enhancer
=========================

Add some features to REST API
(for Redmine 1.4+ and 2.x)

---

    /rest_api_enhancer/issues/<ISSUE_ID>/watchers.<json|xml>

show watchers for ISSUE_ID

JSON output example:

    {"watchers":{"errors":[],"items":[{"name":"user1 user1","id":3},{"name":"user2 user2","id":4},{"name":"user3 user3","id":5}],"issue_id":10}}
  
---

    /rest_api_enhancer/issues/<ISSUE_ID>/watchers.<json|xml>?user_ids=3,4,5

set watchers for ISSUE_ID

---

    /rest_api_enhancer/users

show all users (with blocked)
