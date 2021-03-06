'use strict';

angular.module('app.controllers', [])

# overall control
.controller('AppCtrl', [
    '$scope', '$rootScope'
    ($scope, $rootScope) ->
        $window = $(window)

        $scope.main =
            brand: 'HopStack'
            name: 'Head Hopmaster' # those which uses i18n directive can not be replaced for now.
            description: 'A beautifully crafted application stack for software teams'
            website: 'www.hopstack.com'
            email: 'hopmaster@hopstack.com'
            address: '21 Hop Street Portland, OR 12345'
            phone: '123-456-7890'


        $scope.pageTransitionOpts = [
            name: 'Scale up'
            class: 'ainmate-scale-up'
        ,   
            name: 'Fade up'
            class: 'animate-fade-up'
        ,   
            name: 'Slide in from right'
            class: 'ainmate-slide-in-right'
        ,   
            name: 'Flip Y'
            class: 'animate-flip-y'
        ]

        $scope.admin =
            layout: 'wide'                                  # 'boxed', 'wide'
            menu: 'vertical'                                # 'horizontal', 'vertical'
            fixedHeader: true                               # true, false
            fixedSidebar: true                             # true, false
            pageTransition: $scope.pageTransitionOpts[0]    # unlimited, check out "_animation.scss"

        $scope.$watch('admin', (newVal, oldVal) ->
            # manually trigger resize event to force morris charts to resize, a significant performance impact, enable for demo purpose only
            # if newVal.menu isnt oldVal.menu || newVal.layout isnt oldVal.layout
            #      $window.trigger('resize')

            if newVal.menu is 'horizontal' && oldVal.menu is 'vertical'
                 $rootScope.$broadcast('nav:reset')
                 return
            if newVal.fixedHeader is false && newVal.fixedSidebar is true
                if oldVal.fixedHeader is false && oldVal.fixedSidebar is false
                    $scope.admin.fixedHeader = true 
                    $scope.admin.fixedSidebar = true 
                if oldVal.fixedHeader is true && oldVal.fixedSidebar is true
                    $scope.admin.fixedHeader = false 
                    $scope.admin.fixedSidebar = false 
                return
            if newVal.fixedSidebar is true
                $scope.admin.fixedHeader = true
            if newVal.fixedHeader is false 
                $scope.admin.fixedSidebar = false

            return
        , true)


        $scope.color =
            primary:    '#567500'
            success:    '#87BA01'
            info:       '#C6CD50'
            infoAlt:    '#666699'
            warning:    '#FAC552'
            danger:     '#E9422E'



])

.controller('HeaderCtrl', [
    '$scope'
    ($scope) ->

        $scope.introOptions =
            steps: [
                element: '#step1',
                intro: "<strong>Heads up,</strong> You can change the layout"
                position: 'bottom'
            ,
                element: '#step2'
                intro: "Select a different language",
                position: 'left'
            ,
                element: '#step3'
                intro: "Collapsed nav for both horizontal nav and vertical nav",
                position: 'right'
            # ,
            #     element: '#step4'
            #     intro: "Color swatches",
            #     position: 'right'
            ]
])

.controller('NavContainerCtrl', [
    '$scope'
    ($scope) ->


])

.controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter'
    ($scope, taskStorage, filterFilter) ->
        # init
        tasks = $scope.tasks = taskStorage.get()
        $scope.taskRemainingCount = filterFilter(tasks, {completed: false}).length

        $scope.$on('taskRemaining:changed', (event, count) ->
            $scope.taskRemainingCount = count
        )
])

.controller('DashboardCtrl', [
    '$scope'
    ($scope) ->

])


