# Linux and Git

## Linux

### The command line:

- text interface with basic abilities:
    - manipulate files
    - launch programs
    - manage system resources
- UNIX-like command-line
    - defines what kind of commands can be run(`ls`, `cd`, ...)
- many alernatives
    - default command line on Linux is `bash`
    - MacosX has `zsh: `
    - under Windows:
        - Git Bash (gets installed automatically with Git)
        - Windows Linux Subsystem: you can add the Linux kernel to windows...
        - if you use Julia, typing `;` in the console switches it to bash mode
- to follow this lecture you need:
    - *any* UNIX-like shell to provide basic commands
    - git

### Basic commands



## Version Control

### What is under version control?

- Keeps history of all modifications for:
    - the content of a directory
    - all files staged for VCS
- Can switch the content of a directory to:
    - a past version (a past commit)
    - a version written by a collaborator (a commit on another branch)
- Can merge the work done concurrently (merge commits from different branches)

---

### Diff

- How can one track modifications between in a directory in two successive states?
    - watch for new/deleted/renamed files
    - compute the difference between the content of a given file in two different states (a `diff`)

---

### Diff: Example

Type the following instructions (you can use a text editor to edit the files instead):

- create a new, empty file: `touch file.txt`
- write a few lines in this file: `echo "Line 1\nLine 2\nLine 3\nLine 4" > file.txt`
    - "\n" means end of line under Linux
    - `echo` writes its argument to the pipe `>` writes the pipe to a file
- look a the original file `cat file.txt`
``` linenums="1"
Line 1
Line 2
Line 3
Line 4
```
- change one of the line and write the result in another file: `sed '2 c Line 1a' file.txt > newfile.txt`
- look at the resulting file: `cat newfile.txt`
``` linenums="1"
Line 1
Line 1a
Line 3
Line 4
```
- compute the change and store the result in patch: `diff -u file.txt newfile.txt > patch`
    - option `-c` instructs the `diff` program to add contextual information which creates a more verbose patch and also one that is more robust to changes in the original file
- look at the patch: `cat patch`:
```diff linenums="1"
--- newfile_from_patch.txt      2020-05-05 12:38:12.498602372 +0200
+++ newfile.txt 2020-05-06 11:17:38.938087155 +0200
@@ -1,3 +1,4 @@
 Line 1
-"Line 1a"
- Line 3
+Line 1a
+Line 3
+Line 4
```

    - content is self-explanatory

- now apply the patch to create a new file with the same modification: `patch -i patch -u file.txt -o newfile_from_patch.txt`
    - this applies the changes included in input (`-i`) file `patch`...
    - assuming input is in the universal format (`-u`)
    - to file `file.txt`
    - to produce `newfile_from_patch.txt`
- we can check both files are identical: `cat newfile_from_patch.txt` and `cat newfile.txt` are identical
    - `cat newfile_from_patch.txt`
``` linenums="1"
Line 1
Line 1a
Line 3
Line 4
```
    - or `diff newfile.txt newfile_from_patch.txt`



<!-- ??? note
    Story of end of line -->

---

### From diff to git history

- To record history Git stores differences between successive revisions.
- Current revision from an older revision by applying recursively all modifications that happened since.
- The action of storing a revision, i.e. computing the `diff` which defines it is called a commit.
- One can represent all past commits of a given revision as a one branch tree.

---

### From diff to git history: example

- Let's create an empty directory and do some version control in it:
    - `mkdir linear_history`
    - `cd linear_history`
    - `git init`: start versioning in it by creating an empty git repository. This creates a hidden `.git` folder which will store all the git history
- Create a new, empty file: `touch file.txt`
- Make some edits `echo "Line 1\nLine 2\nLine 3\nLine 4" > file.txt`
- Check the status: `git status`
    ```
    On branch master

    No commits yet

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            file.txt

    nothing added to commit but untracked files present (use "git add" to track)
    ```
- Put this file under version control: `git add file.txt`
- Now `git status` records the fact there is a file under version control whose modifications have not been recorded.
    ```
    On branch master

    No commits yet

    Changes to be committed:
      (use "git rm --cached <file>..." to unstage)

        new file:   file.txt
    ```
- Commit this modifications: `git commit -a -m "Created file.txt"`

    ```
    [master (root-commit) cb39aac] Created file.txt
     1 file changed, 4 insertions(+)
     create mode 100644 file.txt
    ```

    - note the commit message which helps our future selves understand what's going on
    - this records a new revision, identified by commit number `cb39aac`

- Let's make some more modifications: `sed -i '2 c Line 1a' file.txt`
    - `-i` stands for inplace modifications
- Commit them `git commit -a -m "Changed line 2"`(no need to add `file.txt` as it is already under version control)
- Let's do some more edits: `sed -i '3 c Line 2' file.txt > newfile.txt`
- And commit them `git commit -a -m "Changed line 3"`
- Now we can look at the history: `git log`

    ```
    commit 9a320760c874c7f8bf25e89d2077d4525c5f8e45 (HEAD -> master)
    Author: Winant Pablo <pablo.winant@gmail.com>
    Date:   Wed May 6 12:16:44 2020 +0200

        Changed line 3

    commit 0c4c1ebb9f4ce078f0e35b3a06a6f53b18c54db0
    Author: Winant Pablo <pablo.winant@gmail.com>
    Date:   Wed May 6 12:16:09 2020 +0200

        Changed line 2

    commit 03e2c8ca95170a413d3c0aa84fc940c66ac2cfe3
    Author: Winant Pablo <pablo.winant@gmail.com>
    Date:   Wed May 6 12:15:21 2020 +0200

        Created file.txt

    ```

    - Now we have nice history.

- We can see what happened since a particular commit: `git diff HEAD 03e2c8ca95170a413d3c0aa84fc940c66ac2cfe3`
    ```diff
    diff --git a/file.txt b/file.txt
    index f36933c..e579141 100644
    --- a/file.txt
    +++ b/file.txt
    @@ -1,4 +1,4 @@
     Line 1
    -Line 1a
     Line 2
    +Line 3
     Line 4
    ```

- Now look back at the  "HEAD" word in the git log: it means that our directory is currently synchronized with the latest commit. Indeed the content of `file.txt` is the result from all edits (check `cat file.txt`). Let's explore the past, we copy the commit number of the first modification and check it out: `git checkout 03e2c8ca95170a413d3c0aa84fc940c66ac2cfe3`

    ```
    Note: checking out '03e2c8ca95170a413d3c0aa84fc940c66ac2cfe3'.

    You are in 'detached HEAD' state. You can look around, make experimental
    changes and commit them, and you can discard any commits you make in this
    state without impacting any branches by performing another checkout.

    If you want to create a new branch to retain commits you create, you may
    do so (now or later) by using -b with the checkout command again. Example:

      git checkout -b <new-branch-name>

    HEAD is now at 03e2c8c Created file.txt
    ```

    - `cat file.txt` shows that the file has reverted to its former state

    ``` linenums="1"
    Line 1
    Line 2
    Line 3
    Line 4
    ```

    - note that from the message above, you are in "detached mode": if you make modifications, they would conflict with the actual history wouldn't they ? You can make them but they will be discarded when you go back to the most revision. That is unless you save them in a branch. (in the next slide)

- Let's go back to the latest revision and check everything is normal: `git checkout master` and `git log`
    - here `master` is the name of the default branch and `git checkout master` means "go to latest commit on master branch". We cold also have done `git checkout 9a320760c874c7f8bf25e89d2077d4525c5f8e45`


---

### Merging files

- So far we have seen how to record revison history. This is already quite useful but on the tip of the git iceberg.

- What happens if, starting from a given file, we make concurrent modifications ? Can we merge them together ?
    - if two people edit different files no problem: just keep the two of them
    - if two people edit the same file, we have a merge issue

---

### Merging files (example)

Consider the following story. Mr A writes a file `text` with the following content (to tell the truth he used a lorem ipsum generator):

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Duis ac tristique erat.
Nullam et lorem dignissim sem efficitur fringilla a eget justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
In maximus diam ac lorem aliquam, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
Nulla dapibus magna nibh, ac rutrum lorem viverra quis.
```

He then asks two collaborators B and C to propose modifications. B proposes `text_B` (he used google translate some of A's text):

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Duis ac tristique erat.
relais de football Lorem et une salade de thérapie écologique besoin.
Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
In maximus diam ac certains lorem, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
Nulla dapibus magna nibh, ac rutrum lorem viverra quis.
```

Just before the deadline, C proposes `text_C`:

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Duis ac tristique erat.
Nullam et lorem dignissim sem efficitur fringilla a eget justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
In maximus diam ac algunos lorem, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
Nulla dapibus nibh, ac rutrum lorem viverra quis.
```

What should Mr A do ?

- He can compte the changes (diff) proposed by B and C:
    - by B `diff -u text text_B > patch_B`

    ```diff linenums="1"
    --- text        2020-05-06 13:02:43.006841045 +0200
    +++ text_B      2020-05-06 13:02:54.762919889 +0200
    @@ -1,5 +1,6 @@
     Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     Duis ac tristique erat.
    -Nullam et lorem dignissim sem efficitur fringilla a eget justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
    -In maximus diam ac lorem aliquam, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
    +relais de football Lorem et une salade de thérapie écologique besoin.
    +Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
    +In maximus diam ac certains lorem, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
     Nulla dapibus magna nibh, ac rutrum lorem viverra quis.
    ```

- by C `diff -u text text_C > patch_C`

    ```diff linenums="1"
    --- text        2020-05-06 13:02:43.006841045 +0200
    +++ text_C      2020-05-06 13:03:57.855340061 +0200
    @@ -1,5 +1,5 @@
     Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     Duis ac tristique erat.
     Nullam et lorem dignissim sem efficitur fringilla a eget justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
    -In maximus diam ac lorem aliquam, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
    -Nulla dapibus magna nibh, ac rutrum lorem viverra quis.
    +In maximus diam ac algunos lorem, nec mollis nunc vehicula. Fusce sodales est eget risus imperdiet, a rhoncus nunc malesuada.
    +Nulla dapibus nibh, ac rutrum lorem viverra quis.

    ```

- Now he can B and C are proposing to change different lines, except the one starting with "In maximus" that they both want to change. He can then keep the change from both of them.
- In practice he uses a merging tool (like meld)
    - TODO: include screenshot
