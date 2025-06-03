{
  fish_command_not_found = ''    ;
      set responses \
          "The force is not strong with this one: ‘"(status current-command)"’." \
          "I find your lack of ‘"(status current-command)"’... disturbing." \
          "‘"(status current-command)"’ did not make the Kessel Run in less than twelve parsecs." \
          "It's a trap! ‘"(status current-command)"’ does not exist." \
          "These aren't the commands you're looking for: ‘"(status current-command)"’." \
          "Do or do not, there is no ‘"(status current-command)"’." \
          "Help me Obi-Wan Kenobi, ‘"(status current-command)"’ is missing." \
          "Chewie, we're home. But ‘"(status current-command)"’ isn't." \
          "I have a bad feeling about this ‘"(status current-command)"’ thing." \
          "I sense a disturbance in the shell. ‘"(status current-command)"’ cannot be found." \
          "You were the chosen one, ‘"(status current-command)"’!" \
          "This is not the ‘"(status current-command)"’ you’re looking for." \
          "Stay on target... oh, wait, ‘"(status current-command)"’ missed." \
          "Yoda says, ‘No ‘"(status current-command)"’, there is.’" \
          "The dark side clouds everything. Even ‘"(status current-command)"’." \
          "May the force be with you... but not with ‘"(status current-command)"’." \
          "Luke, I am your... wait, where’s ‘"(status current-command)"’?" \
          "A long time ago, in a shell far, far away: ‘"(status current-command)"’ was missing." \
          "I’ve got a bad feeling about this ‘"(status current-command)"’ situation." \
          "Let the Wookiee win. But not ‘"(status current-command)"’." \
          "Han shot first, but ‘"(status current-command)"’ missed." \
          "The droids you’re looking for don’t know ‘"(status current-command)"’." \
          "Jedi mind tricks don’t work on ‘"(status current-command)"’." \
          "The shell is strong with this one, but ‘"(status current-command)"’ is not." \
          "This command belongs in a museum. Unfortunately, not ‘"(status current-command)"’." \
          "There is no escape. Don’t make me execute Order 66 on ‘"(status current-command)"’." \
          "‘"(status current-command)"’? Never heard of it in all my years in the Rebellion." \
          "Traveling through hyperspace ain't like dusting crops, kid. Especially for ‘"(status current-command)"’." \
          "The command you seek does not exist. Only a Sith deals in absolutes." \
          "In my experience, there is no such thing as ‘"(status current-command)"’." \
          "‘"(status current-command)"’ is not a protocol droid." \
          "Fear is the path to the dark side. Fear of missing ‘"(status current-command)"’." \
          "The ability to destroy a planet is insignificant next to the power of ‘"(status current-command)"’... oh wait, never mind." \
          "Remember, the Force will be with you. Always. But not with ‘"(status current-command)"’." \
          "Much to learn, you still have. Including ‘"(status current-command)"’." \
          "I've been waiting for you, ‘"(status current-command)"’. We meet at last... or not." \
          "Now, young Padawan, you will realize the true power of a missing command." \
          "If only you knew the power of the dark side. ‘"(status current-command)"’ is not found." \
          "Your powers are weak, old command: ‘"(status current-command)"’." \
          "The Force will be with you... but not for ‘"(status current-command)"’."
      echo (random choice $responses)
  '';
}
