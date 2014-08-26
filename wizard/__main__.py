from sh import git, cd
import subprocess
import os
from os import pardir
from os.path import abspath, join
from bottle import Bottle, run, template
chapters = [{u'chapter': u'Einleitung', u'text': u"<p>Um die SOLID-Prinzipien kennenzulernen werden wir die Entwicklung einer Beispielanwendung verfolgen.\n                        Ihr beobachtet das Team FT-Ads dabei ein System nach SOLID zu entwicklen um Werbespr\xfcche f\xfcr Produkte anzuzeigen.\n                        Daf\xfcr solltet ihr das 'exploreSOLID'-Projekt als Gradle-Projekt in IntelliJ importieren.</p>\n                       <p>Wir werden das Beispiel und die Implementierung bewusst simpel halten.\n                          Deshalb kann es gut sein, dass ihr \xfcberhaupt nicht einverstanden seid, wie FT-Ads Features umsetzt.\n                          Macht euch dann bewusst, dass FT-Ads noch unsicher ist, wie man SOLID-Code erreicht.</p>\n                       <p>\n                          Damit der Umfang der Beispielanwendung nicht zu gro\xdf wird, werden wir uns auf das 'O', das 'I' und das 'D' aus SOLID konzentrieren.\n                       </p>\n                       <p>\n                          Mit den zwei Buttons unten k\xf6nnt ihr durch das Tutorial navigieren. Dadurch wird euer IntelliJ-Workspace eingerichtet.\n                          Das kann ein paar Sekunden dauern. Sobald die Seite vollst\xe4ndig geladen wurde, steht euer Workspace bereit.\n                       </p>\n                       <p> \n                          Wenn ihr soweit seid, klickt auf 'Next Step' um zu sehen, wie FT-Ads die ersten Anforderungen an das neue System umsetzt.\n                       </p>", u'branch': u'master', }, {u'chapter': u'Das MVP', u'text': u"<p>Die erste Version soll folgende Feature beinhalten:</p>\n                         <ol>\n                          <li>Die Werbespr\xfcche werden von den Marketing-Experten gepflegt und sind ab sofort im Produkt-Export des Teams 'Datenversorgung' enthalten.</li>\n                          <li>Ein Werbespruch bezieht sich auf eine Variationen eines Produktes.</li>\n                          <li>Werbespr\xfcche sind immer nur f\xfcr einen Tag g\xfcltig, werden aber mehrere Tage im Voraus gepflegt.</li>\n                          <li>Werbespr\xfcche werden als Templates gepflegt, in denen der Preis und das aktuelle Datum als Variable verwendet werden kann.</li>\n                          <li>In der ersten Version reicht es aus, wenn der Werbespruch nach System.out ausgegeben wird.</li>\n                        </ol>\n                       </p>\n                       <p>\n                          Wechselt jetzt in den Workspace um zu sehen wie FT-Ads das MVP umgesetzt hat.\n                       </p>\n                       <p>Es ist hilfreich, die vier Hauptklassen\n                        <ul>\n                          <li>Product</li>\n                          <li>Variation</li>\n                          <li>Claim</li>\n                          <li>IntegrationTest</li>\n                        </ul>\n                       gleichzeitig in IntelliJ anzuzeigen.</p>\n                       <h2>Frage: Ist die Umsetzung SOLID? Wenn nein, welches SOLID-Prinzip hat FT-Ads bei der Umsetzung verletzt?</h2>", u'branch': u'classic_t1', }, {u'chapter': u'Der Ripple-Effect', u'text': u"<p>FT-Ads hat das DI-Prinzip verletzt. Die Klasse Product ist Compile-abh\xe4ngig von Variation und Claim.\n                           Aus der Traum vom <a style='color:red;' href='http://martinfowler.com/bliki/BoundedContext.html'>Bounded Context</a>.\n                           Eine weitere Konsequenz ist der Ripple-Effect (dessen Auswirkungen auch als Ver\xe4nderungsschockwellen bezeichnet werden).</p>\n                        <p>Um diesen Effect zu beobachten muss man sich nur anschauen, welche Stellen angepasst werden m\xfcssen,\n                           um den Markennamen des Prouktes in den Werbespr\xfcchen zu verwenden.</p>\n                        <p>Der n\xe4chste Schritt ist eigentlich einer zur\xfcck. FT-Ads l\xf6st zuerst die Verletzung des DI-Prinzips auf, bevor es eine neue Anforderung umsetzt.", u'branch': u'classic_t2', }, {u'chapter': u'Abh\xe4ngig - aber richtig!', u'text': u"<p>Nun sind die Abh\xe4ngigkeiten der Klassen auf Compile-Ebene korrekt geordnet.</p>\n                        <h2>Frage: Ist nun alles gut?</h2>\n                        <p>Die Frage beantwortet sich, wenn FT2-Ads im n\xe4chsten Schritt versucht das neue Feature 'Marke im Werbespruch' umzusetzen.</p>", u'branch': u'classic_t1_dip', }, {u'chapter': u'Implizite Abh\xe4ngigkeiten', u'text': u'<p>Die \xc4nderung um das DI-Prinzip zu erf\xfcllen hatte keinen Einfluss auf den Ripple-Effect. Statt einer expliziten Abh\xe4ngigkeit auf Compile-Ebene liegt nun eine\n                           implizite Abh\xe4ngigkeit zu Claim vor: Claim braucht die Marke eines Produktes, also m\xfcssen die Klassen Produkt und Variation ge\xe4ndert werden um die Marke\n                           bis zu Claim herunter zu reichen. Dass der Ripple-Effect weiterhin auftritt ist nicht verwunderlich,\n                           denn die Ber\xfccksichtigung der Marke im Werbespruch ist eine neue Anforderung.\n                           Um den Ripple-Effect bei neuen Anforderungen zu bek\xe4mpfen muss man dan Open/Closed-Prinzip ber\xfccksichtigen. Die Invertierung der Abh\xe4ngigkeiten war jedoch\n                           nicht umsonst, sondern ist Voraussetzung um das OC-Prinzip zu realisieren.', u'branch': u'classic_t2_dip', }, {u'chapter': u'Naive OCP', u'text': u"<p>Nun hat FT-Ads den Holzhammer herausgeholt: Alles was im Produkt oder an der Variation jetzt oder in Zukunft gespeichert wird kann nun im Werbespruch verwenden werden.\n                           Claim ist also nun offen f\xfcr Erweiterungen ('open') und Product und Variation sind geschlossen gegen\xfcber Ver\xe4nderungen,\n                           die sich nur aus Anforderungen an das Modul Claim ergeben.</p>\n                       <h2>Frage: Gen\xfcgt die Umsetzung damit dem OC-Prinzip?</h2>", u'branch': u'classic_t1_dip_ocp', }, {u'chapter': u'Append only', u'text': u'<p>FT-Ads hat nun eine stabile Abstraktion geschaffen, mit der sie die meisten m\xf6glichen zuk\xfcnftigen Anforderungen nur durch das Hinzuf\xfcgen von Code umsetzen k\xf6nnen,\n                           ohne dabei bestehenden Code \xe4ndern zu m\xfcssen. Nat\xfcrlich sind auch Anforderungen denkbar, welche sich nicht durch eine ReplacingStrategy l\xf6sen lassen.\n                           Das ist aber auch ok, weil wir nicht open f\xfcr alle denkbaren Anforderungen sein k\xf6nnen und auch nicht wollen, um kein hyper-generisches System pflegen zu m\xfcssen.\n                           Um die richtigen Abstraktionen zu finden, ist es deshalb sehr vorteilhaft sich mit dem Product Owner \xfcber m\xf6gliche Richtungen abzustimmen,\n                           in die sich das System entwickeln kann.</p>\n                        <h2>Frage: Ist der Code endlich SOLID?</h2>\n                        <p>Nein. Wer findet den Werwolf?</p>', u'branch': u'classic_t1_dip_ocp_add_only', }, {u'chapter': u'Das Interface Segregation Principle', u'text': u"<p>FT-Ads hat den Bug gefunden und durch die Erf\xfcllung des Interface Segregation Principle sichergestellt, dass diese Art von Fehler nicht mehr auftreten kann.\n                           Zus\xe4tzlich wurde die Kopplung zum Produkt verringert, so dass ein Claim nun mit beliebigen Implementation von 'ReadOnlyProduct' arbeiten kann.</p>\n                        <p>Ironischerweise ist die Anwendung nun weniger 'open/closed' hinsichtlich des Renderings eines Werbespruchs als zuvor.\n                           Sollen weitere Attribute einer Variation im Werbespruch aufgenommen werden (beispielsweise die Farbe), kann FT-Ads nicht mehr das Interface Buyable verwenden.</p>\n                        <p>\n                           Sie k\xf6nnten \xe4hnlich wie beim Produkt mit einer ReadOnlyVariation arbeiten, die alle Attribute mit lesendem Zugriff zur Verf\xfcgung stellt. Wie auch beim\n                           beim ReadOnlyProduct ist jedoch nur eine Frage der Zeit, bis man mit dieser Variante erneut gegen das ISP verst\xf6\xdft\n                           ('Many client specific interfaces are better than one general purpose interface'). Auch wenn durch ein ReadOnly-Interface keine Seiten-Effecte autreten k\xf6nnen,\n                           so schafft es doch unn\xf6tige Kopplung, reduziert damit die Wiederverwendung und vergr\xf6\xdfert den <a style='color:red;' href='http://martinfowler.com/bliki/BoundedContext.html'>Bounded Context</a>.\n                       </p>\n                       <p>\n                           Die andere Variante w\xe4re, dass die Klasse Variation ein Interface implementiert, das im Modul Variation liegt, aber nur die Attribute ver\xf6ffentlicht, welche f\xfcr\n                           die Replacing-Strategies relevant sind. Diese Variante w\xfcrde das IS-Prinzip erf\xfcllen. Das DI-Prinzip w\xe4re daf\xfcr verletzt - zwar nicht auf Compile-Ebene,\n                           aber immer wenn eine neue Information der Variation im Werbespruch ben\xf6tigt wird, m\xfcsste man das Modul Variation anpassen (um das spezifische Interface zu \xe4ndern).\n                           Das Modul Variation w\xe4re somit implizit abh\xe4ngig von Claim-Modul.\n                       </p>\n                       <h3>Food For Thought: Wie s\xe4he die Anwendung komplett nach SOLID aus? Und will man das eigentlich?</h3>", u'branch': u'classic_t1_dip_ocp_add_only_isp', }]

def is_empty(coll):
    return coll == None or len(coll) == 0

def first(coll):
    return coll[0]

def rest(coll):
    return coll[1:]

def index_chapters(l, index):
    if (not is_empty(l)):
        first(l)[u'index'] = index
        _hy_anon_var_1 = index_chapters(rest(l), index + 1)
    else:
        _hy_anon_var_1 = None
    return _hy_anon_var_1
index_chapters(chapters, 0L)
base_tpl = u"<!DOCTYPE html>\n<html lang='en'>\n  <head>\n    <meta charset='utf-8'>\n    <meta http-equiv='X-UA-Compatible' content='IE=edge'>\n    <meta name='viewport' content='width=device-width, initial-scale=1'>    <link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'>\n    <link rel='stylesheet' href='//getbootstrap.com/examples/cover/cover.css'>\n  </head>\n   <body>\n\n    <div class='site-wrapper'>\n\n      <div class='site-wrapper-inner'>\n\n        <div class='cover-container'>\n\n          <div class='masthead clearfix'>\n            <div class='inner'>\n              <h3 class='masthead-brand'>Explore SOLID</h3>\n              <ul class='nav masthead-nav'>\n                <li><a href='/'>Start</a></li>\n              </ul>\n            </div>\n          </div>\n\n          <div class='inner cover'>\n            <h1 class='cover-heading'>{{chapter}}</h1>\n            <div style='text-align:left;'>\n              {{!text}}\n            </div>\n            <p class='lead'>\n              <a href='{{prev}}' class='btn btn-lg btn-default'>Previous Step</a>\n              <a href='{{next}}' class='btn btn-lg btn-primary'>Next Step</a>\n            </p>\n          </div>\n\n          <div class='mastfoot'>\n            <div class='inner'>\n              <p>SOLID Workshop for FT2</p>\n            </div>\n          </div>\n\n        </div>\n\n      </div>\n\n    </div>    <!-- Bootstrap core JavaScript\n    ================================================== -->\n    <!-- Placed at the end of the document so the pages load faster -->\n    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>\n  </body>\n</html>"
app = Bottle()

def add_whitespace(a, b):
    return ((a + u' ') + b)

def nth(coll, index):
    return coll[index]

def gradle(*args):
    return subprocess.check_call(*[(u'./gradlew ' + reduce(add_whitespace, args))], **{u'shell': True, })

def git_checkout(branch):
    return git(u'checkout', branch)

def create_branch_filter(branch):

    def _hy_anon_fn_5(s):
        return (branch == s[u'branch'])
    return _hy_anon_fn_5

def is_nil(obj):
    return obj == None

def find_current_step(branch):
    step = nth(filter(create_branch_filter(branch), chapters), 0L)
    return (nth(chapters, 0L) if is_nil(step) else step)

def find_step(index):
    return nth(chapters, index)[u'branch']

def find_prev_step(index):
    return find_step(index - 1)

def find_next_step(index):
    return find_step(index + 1)

def show_page(branch):
    current_step = find_current_step(branch)
    index = current_step[u'index']
    vars = dict(find_current_step(branch))
    if (index == 0L):
        vars[u'prev'] = u'#'
        _hy_anon_var_2 = None
    else:
        vars[u'prev'] = (u'/' + find_prev_step(index))
        _hy_anon_var_2 = None
    if (index == (len(chapters) - 1L)):
        vars[u'next'] = u'#'
        _hy_anon_var_3 = None
    else:
        vars[u'next'] = (u'/' + find_next_step(index))
        _hy_anon_var_3 = None
    return template(*[base_tpl], **vars)

def do_step(branch):
    git(u'stash')
    git_checkout(find_current_step(branch)[u'branch'])
    gradle(u'clean', u'idea', u'iM')
    return show_page(branch)

@app.route(u'/favicon.ico')
def favicon():
    return None

@app.route(u'/<step>')
def wizard(step):
    return do_step(step)

@app.route(u'/')
def wizard_start():
    return do_step(u'master')
(run(*[app], **{u'host': u'localhost', u'port': 8090L, u'debug': False, }) if (__name__ == u'__main__') else None)
