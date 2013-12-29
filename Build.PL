use 5.008;
use strict;
use warnings FATAL => 'all';
use Module::Build;
use Config;

if (-d ".git") {
    my ($dir, $manifest);
    open $manifest, ">", "MANIFEST" or die "MANIFEST: $!";
    print $manifest "MANIFEST\n";
    print $manifest `git ls-files`, "\n";
}

my $builder = Module::Build->new(
    module_name         => 'OCBNET::CSS3',
    license             => 'perl',
    dist_author         => q{Marcel Greter <marcel.greter@ocbnet.ch>},
    dist_abstract       => 'Parse, manipulate and render CSS files',
    dist_version_from   => 'lib/OCBNET/CSS3.pm',
    release_status      => 'stable',
    create_license      => 1,
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'File::Slurp' => 0,
    },
    meta_merge => {
      resources => {
        repository  => 'https://github.com/mgreter/OCBNET-CSS3',
      },
    },
    add_to_cleanup     => [ 'OCBNET-CSS3-*' ],
    $Config{cc} eq 'clang' ? (
        # clang has a bunch of asinine warnings on by default:
        extra_compiler_flags => '-Wno-parentheses -Wno-tautological-compare -Wno-unused-value',
    ) : (),
    extra_linker_flags => '',
);

$builder->create_build_script();
