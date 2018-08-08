SomePractice
===============

https://some-practice.herokuapp.com/

GET https://some-practice.herokuapp.com/api/questions?api_key=53c0739c4304d7791843df27cd9264e9&terms[]=PROVIDENT

Tenants:

a)

Api key: 53c0739c4304d7791843df27cd9264e9

Questions(public): 3(2)

b)

Api key: 10fdb3a596dd069023df16cafe0c4369

Questions(public): 3(2)

c)

Api key: 384beab99e4d4eb0d747f73f47e02327

Questions(public): 3(0)



Considerations:

1) I used a RoR bootstrap in the project so it's probable that the repository have unused gems and configurations.
1) I assumed that the questions have a relation n:1 to the tenants.
2) I took a little time to make the dashboard page because styling takes a lot of time and i understood that this was not the main feature of the example.
3) I didn't have a lot of time to code, so the tests are simple ones, also i didn't take the time to test the throttler middleware.
4) The seed has 3 users, 3 tenants, 4 questions per tenant, and 3 answers per question.
5) The terms in the query are case insensitive and exclusive (term1 && term2).
6) I thought of using Rack::Attack, but it seems to not have a configuration like the desired (start throttling after 100 requests).

Greetings
