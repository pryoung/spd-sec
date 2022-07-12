# IDL software for processing membership information for the Solar Physics Division of the American Astronomical Society. 

The software is intended for use by the SPD Secretary.

The tables of SPD member information used by this software are not publicly available. 

The SPD member tables should be downloaded from a member's account in CSV format. They should be stored in a directory that is pointed to by the environment variable $SPD_MEMBERS. The tables should be named, e.g., spd_members_20220712.csv, where the date is the download date of the table.

The downloaded CSV files may contain DOS carriage return characters (^M). This can be fixed by running the Unix command:

```
> tr '\r' ' ' < old_file.csv > new_file.csv
```

## Examples

Plot the number of members (or full members, 'F') as a function of time:

```
IDL> p=spd_plot_history()
IDL> p=spd_plot_history(type='f')
```

Print the current numbers of members of each type:

```
IDL> spd_member_stats,/type
```

Print member breakdown by country:

```
IDL> spd_member_stats,/country
```

Print information about a member:

```
spd_find_member,'Young'
```
