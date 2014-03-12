---
date: 12 March 2014
categories: intermediate, guides
author: Chris Michel
summary: Sass has come a long way over the years. I’ve been using it since the days of the `:property value` syntax. It’s always been easy to find Sass documentation on how specific functions and such work under the hood of Sass, but it’s never been easy to find out what others are building.
---

# Share your Sass with Sache: A quick quide

Sass has come a long way over the years. I’ve been using it since the days of the `:property value` syntax. It’s always been easy to find Sass documentation on how specific functions and such work under the hood of Sass, but it’s never been easy to find out what others are building with Sass. Sure, a few tools pop out of the woodwork and get some big traction, but there are tons more out there being built by brilliant Sassophiles. That’s where [Sache](http://www.sache.in) comes in.

Sache is an open-source hub for finding Sass and Compass tools for your next project. [Jared Hardy](http://www.twitter.com/jaredhardy) and I worked to make Sache as easy to use as possible for anyone wanting to share or discover tools.

## Sharing Sass Tools

The simple 2-step process makes it painless to add your Extension to the mix so that people can find it and use it! There is one small caveat to Sache: you must have your code checked into a public Github repo first. If you need help creating a Github repo, check out [Set Up Git](https://help.github.com/articles/set-up-git) and [Create a Repo](https://help.github.com/articles/create-a-repo) from the Github help site.

Here’s how to add your tools once its on Github:

1) Add a `sache.json` [file](https://github.com/jhardy/Sassy-Buttons/blob/master/sache.json) to your repository that contains the following information pattern:

    {
        "name": "project-name",
        "description": "Description of project",
        "tags": ["ui", "buttons", "etc"]
    }

2) Visit [http://www.sache.in](http://www.sache.in) and click the “Add Your Own” or “Add Extension” button and enter your Github project SSH URL, then click “Add”. If you need help finding your SSH URL, here's an [example image](http://d.pr/i/GN5).

3) Congratulations, you’re done. Your project will now appear on Sache.

## Finding Sass Tools

With every Sache tools comes the data we need to let you sort by stars, title, author, etc. We’ve also added in functionality to filter results based on the tags that are submitted with each submission. If you want to filter the table results, simply click the header of the table column or the name of the tag or author.

You might already know exactly what type of extension you are looking for. In that case, you can use the search bar in the upper right of the page to enter keywords, author names, extension names, etc. We’ll show you what we find that matches your terms.

Each tool inevitably links over to a Github page that the author for the tool maintains. This let’s documentation and installation instructions in the hands of the project owners since they know their tools the most. In most cases, you’ll find installation instructions in the README.md file on the Github repo.

## Conclusion

Now that you know how to add your own tools to Sache, get out there and create an awesome Sass tools for others like you to enjoy. You’d be surprised what others find useful and what you can learn just by looking at the code from other projects.

Feel free to follow [Sache on Twitter](http://www.twitter.com/sache_in), we share [daily sass tools](https://twitter.com/search?q=%23DailySassTool&src=hash) almost every day.