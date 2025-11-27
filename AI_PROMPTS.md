Using the current file structure and taking reference from challenge.md, create a Local Code Review + Commit Helper claude code plugin. This plugin will feature 2 commands, 1 skill and 1 hook.

As you can see I have changed the hook command to "echo 'HOOK WORKS'" to try and get it working but that echo is not showing up in Claude Code after a write. Based on the previous context as well what could most likley be the issue?

Okay that previous step is sorted and it is loading in with commands, skills and hooks in the plugin.json. I would now like to test the skills functionality. I have also provided the plugin.json below: _plugin.json_. What is the best way for me to test the skills functionality?

'For local development you can use a simple folder as a marketplace': For this folder should I do it in the same project with my plugin or a new one?

For a claude code plugin give a good example structure for a code review skill that takes in git context and includes severity and safety checks in the SKILL.md
