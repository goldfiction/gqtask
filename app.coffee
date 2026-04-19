fs=require "fs"
chalk=require "chalk"

log=console.log
cmd=process.argv[4]
file=process.argv[2]||"todos.json"
#log file
#log cmd

run=()->
  try
    todos=JSON.parse(fs.readFileSync(file).toString())
  catch e
  #log "file imported..."
  if cmd=="list"
    log todos.name
    for todo,i in todos.todos
      if todo.done
        log i+"\t"+chalk.green(" ✓ ")+"  "+todo.title
      else
        log i+"\t"+chalk.red(" x ")+"  "+todo.title
  else if cmd=="add"
    todos.todos.push {done:false,title:process.argv[5]}
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done"
  else if cmd=="remove"
    index=JSON.parse(process.argv[5])
    todos.todos.splice(index, 1)
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done" 
  else if cmd=="done"
    index=JSON.parse(process.argv[5])
    todos.todos[index].done=true
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done" 
  else if cmd=="undone"
    index=JSON.parse(process.argv[5])
    todos.todos[index].done=false
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done" 
  else if cmd=="toggle"
    index=JSON.parse(process.argv[5])
    todos.todos[index].done=!!(!todos.todos[index].done)
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done"
  else if cmd=="init"
    todos={}
    todos.name=process.argv[5]
    todos.todos=[]
    fs.writeFileSync(file,JSON.stringify(todos,null,2))
    log "done"

run()