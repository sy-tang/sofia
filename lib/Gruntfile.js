module.exports = function(grunt) {
    grunt.initConfig({
        dirs: {
            src: '../src',
            js: '../src/js'
        },

        connect: {
            server: {
                options: {
                    hostname: '0.0.0.0',
                    port: 7777,
                    base: ['./', '<%= dirs.src %>'],
                    keepalive: true
                }
            }
        },

        coffee: {
            compile: {
                expand: true,
                options: {
                    bare: true
                },
                cwd: '<%= dirs.js %>',
                src: '**/*.coffee',
                dest: '<%= dirs.js %>',
                ext: '.js'
            }
        },

        watch: {
            coffee: {
                files: ['<%= dirs.js %>/**/*.coffee'],
                tasks: ['coffee:src']
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-connect');

    grunt.registerTask('default', ['coffee:compile']);
    grunt.registerTask('server', ['connect:server']);
};
