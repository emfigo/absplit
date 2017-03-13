[![Build Status](https://api.travis-ci.org/emfigo/absplit.png)](https://api.travis-ci.org/emfigo/absplit)

ABSplit
=====

The aim of ABSplit is a form of statistical hypothesis testing based on weights given by the user. 

##Installation

 ```ruby
   gem install 'a_b_split'
 ```

##Usage

In order to use the gem it's necessary to initialize the configuration with all the experiments that you are going to use in your application

```ruby
  ABSplit.configure do |config|
    config.experiments = { 
                           'experimentA' => [ { 'name' => 'optionA', 
                                                'weight' => 50 },
                                              { 'name' => 'optionB' } 
                                            ] 
                         }
  end
```

You can specified an algorithm to be used in your experiment

```ruby
  ABSplit.configure do |config|
    config.experiments =  { 'experiment' =>
                             { 'algorithm' => 'Sigmoid',
                               'options' =>
                                 [ { 'name' => 1, 'weight' => 50 },
                                   { 'name' => 2 } ]
                             }
                          }
  end

```

NOTE: It is important that you select the algorithms from the following list:

|Name|Description|Properties|
|:----|:----------------|:---------|
|WeightedSplit| Weighted split based on hash value |- No collisions are possible - Non persistent (based on memory position)|
|Md5WeightedSplit| Weighted split based on MD5 digest of value |- Persistent - Supports 128 bits as input - Collisions are possible|
|HeavisideWeightedSplit| Weighted split based on a modified Heaviside function |- Persistent - In case a numeric value is passed, it uses a sigmoid function applying a modified Heaviside to choose the experiment - In case a none numeric value is passed it uses SHA2 algorithm to get a value from the object, and after the default behaviour. - Supports 256 bits as input - No collisions are possible|

Also you can set your experiments in a yml file. 

```ruby
experimentA:
  - name: 'optionA'
    weight: 50
  - name: 'optionB'
experimentB:
  - name: 'optionA'
    weight: 33.33
  - name: 'optionB'
  - name: 'optionC'
experimentC:
  algorithm: Md5WeightedSplit
  options:
    - name: 'optionA'
    - name: 'optionB'
experimentD:
  algorithm: HeavisideWeightedSplit
  options:
    - name: 'optionA'
    - name: 'optionB'

```

And load them with the following:

```ruby
  ABSplit.configure do |config|
    config.experiments = YAML.load_file File.join( File.dirname(__FILE__), *%w(.. experiments.yml))
  end
```

Once your experiments are loaded. You can use the splitter in your application

```ruby
  ABSplit::Test.split('experimentA', user_id)
```

IMPORTANT: It is important that you understand how the algorithm chosen by you works. All the algorithms are based on an input to choose an option in the experiment. 

##Recommendations
This gem was meant to be simple and more focused on the splitting itself, not on extra functionality. If you want to track your experiments, you can use tools like Google Analytics.

##Collaboration
Please if you would like to collaborate in this project don't doubt to do so. Is always great to have different views to cover. What is going to be evaluated:
 - Usability
 - That it works !
 - That is covered in test (unit and integration)
 - Simplicity

If you have all this, please open a PR and mention @emfigo so I can take a look.

If you would like to become a collaborator please contact me through my email so we can have a chat.

_“Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live.”_
*Richard Pattis*

##Special Thanks
I want to thank the collaboration from; [FraDim](https://github.com/FraDim), [jpstevens](https://github.com/jpstevens), [sgerrand](https://github.com/sgerrand). Without them none of the improvements would have been possible. Thank you for your ideas and time.
