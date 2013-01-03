# Introduction
This is a small, example utility showing how to determine bandwidth used by an interface. It's a quick and dirty hack that you can hopefully use in some capacity.

# Usage
Building creates the command-line-based 'bwidth' tool. Running bwidth simply dumps bandwidth used by every interface it can find. Following good Unix philosophy, that's all it does. You can run it periodically, and in combination with other utilities (awk, I'm looking at you), slice, dice, and measure the output.