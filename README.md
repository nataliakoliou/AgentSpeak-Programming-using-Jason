# AgentSpeak Programming using Jason
Welcome to the repository of the IAMS-Lab! 🤖

## 🔔 Introduction
Buckle up, because we're about to dive into the fascinating world of AgentSpeak programming using Jason. Whether you're a code wizard or just starting your journey, this repository is your go-to resource for presentations, code examples, exercises, and more.

## 📚 What You'll Find Here
- helpful slides about the AgentSpeak programming language and the Jason interpreter. 
- code examples for both single and multi-agent systems
- engaging challenges to test your skills and understanding
- Course book: Programming Multi-Agent Systems in AgentSpeak Using Jason.

<sup> **NOTE:** Don't forget to check out the official <a href="https://jason-lang.github.io/api/">Jason API</a> for more details on its packages and classes. To access the complete Jason documentation and resources, visit the official <a href="https://jason-lang.github.io/">website</a>.</sup>

## 🛠️ Setup
Follow these steps to set up your development environment in Visual Studio Code with Jason:

1. First, grab the Java SE Development Kit 17.0.8 from [Oracle's official website](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html). After installation, make sure it's working by running `java --version` in your terminal.

   <sup> **Attention:** Jason is only compatible with JDK version 17.0.8! Additionally, you might need to set the [JAVA_HOME](https://docs.oracle.com/cd/E19182-01/821-0917/inst_jdk_javahome_t/index.html) path within your system variables.</sup>

3. If you don't already have it, download and install [Visual Studio Code](https://code.visualstudio.com/download).
4. If you're on Windows, don't forget to install a terminal and shell tool like [GitBash](https://gitforwindows.org/).
5. Now, let's set up Jason:
   ### 🖥️ Windows & Unix
   4.1. Go to the [SourceForge page](https://sourceforge.net/projects/jason/files/) and navigate to `jason/version3.2`. Find **jason-bin-3.2.0.zip**, download and decompress it. You can place it wherever you like, but avoid storing it in the "Program Files" directory!
   
   4.2. Fire up Visual Studio Code and select the Git Bash terminal (View > Terminal > Choose Git Bash).
   
   4.3. In the terminal, type `cd "your_jason_directory\bin"` to get to your Jason directory's bin folder.
   
   4.4. Make the jason file Unix executable with this command: `chmod +x jason`.
   
   4.5. For a smooth experience, add **your_jason_directory/bin** to your system's PATH. This way you can execute the jason command from anywhere! [Here](https://www.computerhope.com/issues/ch000549.htm) are some instructions to help you with this step. To check if it's working, try running `jason --version` in a different directory.

   ### 🐧 Linux
   4.1. Open your terminal and type `echo "deb [trusted=yes] http://packages.chon.group/ chonos main" | sudo tee /etc/apt/sources.list.d/chonos.list` to enable the installation of packages from Chonos repository onto your system.
   
   4.2. Next, run `sudo apt update` to update your package list.
   
   4.3. Finally, install the Jason CLI with `sudo apt install jason-cli`.
   
6. To make life easier, install the Visual Studio Code plugin that provides syntax highlighting for Jason. Look for [JaCaMo4Code](https://marketplace.visualstudio.com/items?itemName=tabajara-krausburg.jacamo4code) in the VS Code Extensions marketplace and give it a click.

## ⚙️ Build your Jason Application
These steps simply show you how to build the default **hello world** app. This app serves as a simple starting point that you can use as a template for your own applications. Feel free to modify or remove the agents, environment, and configuration file to build your own custom app:

1. Go to the Jason bin directory: `cd "your_jason_directory\bin"`

2. Create a default app: `jason app create your_app`. This app comes by default with the system configuration ([.mas2j]()), a basic environment ([.java]()) and two agents: bob and alice ([.asl]()). These agents simply say "hello world" to each other, once you run the application.
   
3. Add an extra agent to your app: `jason app add-agent your_agentname`. This agent simply bahaves like bob and alice, saying "hello world".
   
4. Navigate to your app's directory: `cd your_app`
   
5. Run your app: `jason your_app.mas2j -v`

## 🏆 Acknowledgments
This repository uses the [Jason Interpreter](https://github.com/jason-lang/jason). We would like to thank the developers and contributors for their dedication in creating and maintaining this invaluable tool.

## 🚀 Authors
[Natalia Koliou](https://www.linkedin.com/in/natalia-koliou-b37b01197/) & [Christos Kyriazopoulos](https://www.linkedin.com/in/chris-kyriazopoulos/)
