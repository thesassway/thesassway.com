---
date: 13 March 2014
categories: intermediate, guides
author: Chris Michel
summary: Have you ever created a Sass library and wanted an easy way to share it with others? Or have you ever wondered where to look to find a Sass library to do something specific? In this article Chris Michel introduces us to Sache---an easy to use directory of Sass libraries and tools---and shows us how to easily add our own projects.
---

# Share your Sass with Sache: A quick guide

Sass has really come a long way over the years! I’ve been an avid user of Sass since the days of the indented `:property value` syntax. One of the things that has always bothered me about Sass is that there has never been an easy way to find Sass libraries and extensions. Sure you can do a search on Google but there are no guarantees that you'll hit upon the right combination of keywords to reveal the right library for a particular purpose.

That's why [Jarod Hardy](http://www.twitter.com/jaredhardy) and I set out to create a central place to find Sass extensions and tools. We're calling it [Sache](http://sache.in). Sache is an open-source hub for finding Sass and Compass tools for your next project.


## Sharing Sass tools

The simple 2-step process makes it painless to add your extension so that others can find it and use it! There is one small caveat: to add your project to Sache you must have your code checked into a public GitHub repository. Not familiar with GitHub? No problem.

If you need help creating a GitHub repository, check out these handy guides from the GitHub help site:

* [Set Up Git](https://help.github.com/articles/set-up-git) -- a guide ideal for people just getting started with Git.
* [Create a Repo](https://help.github.com/articles/create-a-repo) -- a simple introduction to creating a repository on GitHub.

Here’s how to add your project to Sache once it’s on GitHub:

1. Add a `sache.json` to your repository that looks something the following. Be sure to customize it for your project:

       :::javascript
       {
         "name": "project-name",
         "description": "Description of project",
         "tags": ["ui", "buttons", "etc"]
       }

2. [Visit the Sache website](http://www.sache.in) and click the “Add Your Own” button at the top and enter your GitHub project SSH URL. If you need help finding your SSH URL it's in the sidebar of your GitHub project's page:

    ![Where to find your SSH URL](/images/articles/ssh-url.png)

That's really all there is to it! Your project will now appear on Sache.


## Finding Sass tools

With every Sass tool added to Sache comes the data we need to let you sort by stars, title, author, etc. If you want to filter the results, simply click the header of the table column  you want to sort by or click on a tag or author name.

You might already know exactly what type of extension you are looking for. In that case, use the search bar in the upper right of the page to enter keywords, author names, extension names, etc. We’ll show you what we find that matches your terms.

Each tool inevitably links over to a GitHub page where you can find installation instructions and documentation in the README file of the repository.

## Conclusion

So what are you waiting for? Head on over to the [Sache website](http://sache.in) and share you own extension or browse through the tools other people have created. 

Also, feel free to follow [Sache on Twitter](http://www.twitter.com/sache_in). We share Sass tools almost every day and use the hash tag [#DailySassTool](https://twitter.com/search?q=%23DailySassTool&src=hash) to make them easy to find.

Care to contribute to Sache? The source code for the Sache website is [on GitHub](https://github.com/jhardy/sache) and we do accept pull requests!
