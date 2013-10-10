module.exports = (grunt) ->
  # Load tasks
  npmTasks = ['coffee', 'jade', 'stylus', 'watch', 'connect']
  grunt.loadNpmTasks("grunt-contrib-#{task}") for task in npmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        expand: true
        cwd: 'app'
        src: ['**.coffee']
        dest: 'public/'
        ext: '.js'
        options:
          bare: true
          join: true

    jade:
      compile:
        files: [
            expand: true
            cwd: 'app'
            src: '**.jade'
            dest: 'public/'
            ext: '.html'
        ]
        options:
          pretty: true

    stylus:
      compile:
        files: [
            expand: true
            cwd: 'app'
            src: '**.styl'
            dest: 'public/'
            ext: '.css'
        ]
        options:
          compress: false

    connect:
      server:
        options:
          port: 8000
          protocol: 'http'
          base: 'public'
          debug: true

    watch:
      coffee:
        files: ['app/*.coffee', 'app/**/*.coffee']
        tasks: 'coffee'
      jade:
        files: ['app/*.jade', 'app/**/*.jade']
        tasks: 'jade'
      stylus:
        files: ['app/*.styl', 'app/**/*.styl']
        tasks: 'stylus'

  grunt.registerTask 'default', [
    'coffee'
    'jade'
    'stylus'
  ]

  grunt.registerTask 'server', [
    'coffee'
    'jade'
    'stylus'
    'connect:server'
    'watch'
  ]
