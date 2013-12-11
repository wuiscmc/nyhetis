nyhetis-core
=======

Description
----------------
nyhetis is an automatic news dossier that crawls newspaper websites and keeps track of relevant news. 

nyhetis-core provides the retrieval functionality and an API so a client can use it eventually. 

Functionality
------------------
nyhetis-core uses [Sinatra](https://github.com/sinatra/sinatra) to provide the needed endpoints and request handlers and [Cobweb](https://github.com/stewartmckee/cobweb) to crawl the newsfeeds. 

Under the hood, it uses [Resque](https://github.com/resque/resque) to queue crawl jobs. Crawling is an expensive job that might take several minutes/hours, so in order to keep the system smooth and responsive, it needs to delegate to another processes this task. 

Since online-newspapers never share their HTML structure, the system provides a strategy to allow future newsfeeds to be added to the crawl. 

Once a page from a newsfeed is downloaded by the crawler, it is validated and processed. The validation is made following the concrete strategy criteria. The concrete strategy would parse the HTML element from the website and extract two things: the text of the new and its heading. The HTML parsing is performed [Nokogiri](http://nokogiri.org). 

The relevance of one new is calculated using a Bag of Words, this means that crawled news would be marked as relevant if contain at least one "word" defined in the bag. 

Supported newspapers
--------------------------------
So far the supported newspapers is the following, even though this list might be extended soon: 
* [Diario Jaen](http://www.diariojaen.es)
* [Viva Jaen](http://www.vivajaen.es) 
* [Ideal Jaen](http://www.ideal.es/jaen)

Use
------

After installing the dependencies, start up the rack server using the config.ru configuration file: 

    rackup config.ru

Testing
----------
While testing the whole system it's needed to activate the workers and activate them in RACK_ENV = test and run nyhetis in testing mode, using RACK_ENV = test again. 

It is provided, along with the tests, a Newspaper Mock that serves a single html site. The code is available under test/newspaper_mock. 

Copyright
-------------
MIT License. Luis Carlos Mateos. 2013 
