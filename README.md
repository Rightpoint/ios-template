# iOS template

A template for new iOS projects at Raizlabs.

Inspired by [suspenders], [django-template], and [Thoughtbot]

[suspenders]: https://github.com/thoughtbot/suspenders
[django-template]: https://github.com/thoughtbot/django-template
[Thoughtbot]: https://thoughtbot.com/

## Usage

1. [Install cookiecutter][cookiecutter] (`brew install cookiecutter` on
   macOS).
2. Run `cookiecutter gh:raizlabs/ios-template`

[cookiecutter]: http://cookiecutter.readthedocs.org/en/latest/installation.html

## Updating Template

Cookie cutter requires a lot of templating that is hard to work with. In particular, files with a variable name in them (`{{ cookiecutter.foo }}`) can not be opened in Xcode. To keep the template easy to update, there's a script `generate_template.sh | sh` which will transform the demo in `PRODUCTNAME` into the template directory. This is a bit meta, but it is very nice to be able to open the project in Xcode in order to maintain the template.
