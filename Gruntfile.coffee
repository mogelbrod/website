module.exports = (grunt) ->
  # Load tasks
  npmTasks = [
    'grunt-contrib-jade'
    'grunt-contrib-coffee'
    'grunt-contrib-stylus'
    'grunt-contrib-watch'
    'grunt-contrib-connect'
    'grunt-contrib-copy'
    'grunt-contrib-clean'
    'grunt-shell'
  ]
  grunt.loadNpmTasks(task) for task in npmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    jade:
      compile:
        files: [
            expand: true
            cwd: 'html'
            src: '**.jade'
            dest: 'build/'
            ext: '.html'
        ]
        options:
          pretty: true

    coffee:
      compile:
        expand: true
        cwd: 'scripts'
        src: ['**.coffee']
        dest: 'build/assets/'
        ext: '.js'
        options:
          bare: true
          join: true

    stylus:
      compile:
        files: [
            expand: true
            cwd: 'css'
            src: '**.styl'
            dest: 'build/assets/'
            ext: '.css'
        ]
        options:
          compress: true
          paths: ['build/assets']
          'include css': true

    copy:
      build:
        files: [
          { expand: true, cwd: 'assets', src: ['**'], dest: 'build/assets' }
        ]

    clean:
      build:
        src: ['build']

    shell:
      generateSprites:
        options:
          stdout: true
          stderr: true
        command: "glue sprite/ build/assets/"

    connect:
      server:
        options:
          port: 8000
          protocol: 'http'
          base: ['build']
          debug: true

    watch:
      jade:
        files: ['html/*.jade', 'html/**/*.jade']
        tasks: 'jade'
      coffee:
        files: ['scripts/*.coffee', 'scripts/**/*.coffee']
        tasks: 'coffee'
      stylus:
        files: ['css/*.styl', 'css/**/*.styl']
        tasks: 'stylus'

  grunt.registerTask 'build', [
    'clean:build'
    'copy:build'
    'shell:generateSprites'
    'jade'
    'coffee'
    'stylus'
  ]

  grunt.registerTask 'server', [
    'build'
    'connect:server'
    'watch'
  ]

  grunt.registerTask 'default', [
    'build'
  ]
