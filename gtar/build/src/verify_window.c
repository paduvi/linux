/* verify_window.c generated by valac 0.30.0, the Vala compiler
 * generated from verify_window.vala, do not modify */

/* Copyright 2015 taprosoft
*
* This file is part of Gtar.
*
* Gtar is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Gtar is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Gtar. If not, see http://www.gnu.org/licenses/.
*/

#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <stdio.h>


#define TYPE_VERIFY_WINDOW (verify_window_get_type ())
#define VERIFY_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_VERIFY_WINDOW, VerifyWindow))
#define VERIFY_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_VERIFY_WINDOW, VerifyWindowClass))
#define IS_VERIFY_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_VERIFY_WINDOW))
#define IS_VERIFY_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_VERIFY_WINDOW))
#define VERIFY_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_VERIFY_WINDOW, VerifyWindowClass))

typedef struct _VerifyWindow VerifyWindow;
typedef struct _VerifyWindowClass VerifyWindowClass;
typedef struct _VerifyWindowPrivate VerifyWindowPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))
#define _g_io_channel_unref0(var) ((var == NULL) ? NULL : (var = (g_io_channel_unref (var), NULL)))

struct _VerifyWindow {
	GtkWindow parent_instance;
	VerifyWindowPrivate * priv;
};

struct _VerifyWindowClass {
	GtkWindowClass parent_class;
};

struct _VerifyWindowPrivate {
	GtkTextView* text_view;
	GtkScrolledWindow* scroll;
};


static gpointer verify_window_parent_class = NULL;

GType verify_window_get_type (void) G_GNUC_CONST;
#define VERIFY_WINDOW_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), TYPE_VERIFY_WINDOW, VerifyWindowPrivate))
enum  {
	VERIFY_WINDOW_DUMMY_PROPERTY
};
VerifyWindow* verify_window_new (const gchar* tar_name);
VerifyWindow* verify_window_construct (GType object_type, const gchar* tar_name);
static void _gtk_window_close_gtk_button_clicked (GtkButton* _sender, gpointer self);
static void verify_window_verify (VerifyWindow* self, const gchar* tar_name);
static gboolean ___lambda18_ (VerifyWindow* self, GIOChannel* channel, GIOCondition condition);
static gboolean verify_window_process_line (VerifyWindow* self, GIOChannel* channel, GIOCondition condition, const gchar* stream_name);
static gboolean ____lambda18__gio_func (GIOChannel* source, GIOCondition condition, gpointer self);
static gboolean ___lambda19_ (VerifyWindow* self, GIOChannel* channel, GIOCondition condition);
static gboolean verify_window_process_error (VerifyWindow* self, GIOChannel* channel, GIOCondition condition, const gchar* stream_name);
static gboolean ____lambda19__gio_func (GIOChannel* source, GIOCondition condition, gpointer self);
static void ___lambda20_ (VerifyWindow* self, GPid pid, gint status);
static void ____lambda20__gchild_watch_func (GPid pid, gint status, gpointer self);
static void verify_window_finalize (GObject* obj);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);
static gint _vala_array_length (gpointer array);


static void _gtk_window_close_gtk_button_clicked (GtkButton* _sender, gpointer self) {
	gtk_window_close ((GtkWindow*) self);
}


VerifyWindow* verify_window_construct (GType object_type, const gchar* tar_name) {
	VerifyWindow * self = NULL;
	const gchar* _tmp0_ = NULL;
	gchar* _tmp1_ = NULL;
	gchar* _tmp2_ = NULL;
	GtkTextView* _tmp8_ = NULL;
	GtkTextView* _tmp9_ = NULL;
	GtkTextView* _tmp10_ = NULL;
	GtkTextView* _tmp11_ = NULL;
	GtkTextView* _tmp12_ = NULL;
	GtkTextView* _tmp13_ = NULL;
	GtkScrolledWindow* _tmp14_ = NULL;
	GtkScrolledWindow* _tmp15_ = NULL;
	GtkScrolledWindow* _tmp16_ = NULL;
	GtkTextView* _tmp17_ = NULL;
	GtkButton* btn_close = NULL;
	GtkButton* _tmp18_ = NULL;
	GtkBox* vbox = NULL;
	GtkBox* _tmp19_ = NULL;
	GtkScrolledWindow* _tmp20_ = NULL;
	const gchar* _tmp21_ = NULL;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (tar_name != NULL, NULL);
	self = (VerifyWindow*) g_object_new (object_type, NULL);
	_tmp0_ = tar_name;
	_tmp1_ = g_strconcat ("Verify ", _tmp0_, NULL);
	_tmp2_ = _tmp1_;
	gtk_window_set_title ((GtkWindow*) self, _tmp2_);
	_g_free0 (_tmp2_);
	g_object_set ((GtkWindow*) self, "window-position", GTK_WIN_POS_CENTER, NULL);
	gtk_window_set_default_size ((GtkWindow*) self, 600, 400);
	{
		GdkPixbuf* _tmp3_ = NULL;
		GdkPixbuf* _tmp4_ = NULL;
		_tmp4_ = gdk_pixbuf_new_from_file ("tar.ico", &_inner_error_);
		_tmp3_ = _tmp4_;
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			goto __catch30_g_error;
		}
		gtk_window_set_icon ((GtkWindow*) self, _tmp3_);
		_g_object_unref0 (_tmp3_);
	}
	goto __finally30;
	__catch30_g_error:
	{
		GError* e = NULL;
		FILE* _tmp5_ = NULL;
		GError* _tmp6_ = NULL;
		const gchar* _tmp7_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp5_ = stderr;
		_tmp6_ = e;
		_tmp7_ = _tmp6_->message;
		fprintf (_tmp5_, "Could not load application icon: %s\n", _tmp7_);
		_g_error_free0 (e);
	}
	__finally30:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return NULL;
	}
	_tmp8_ = (GtkTextView*) gtk_text_view_new ();
	g_object_ref_sink (_tmp8_);
	_g_object_unref0 (self->priv->text_view);
	self->priv->text_view = _tmp8_;
	_tmp9_ = self->priv->text_view;
	gtk_text_view_set_editable (_tmp9_, FALSE);
	_tmp10_ = self->priv->text_view;
	gtk_text_view_set_cursor_visible (_tmp10_, FALSE);
	_tmp11_ = self->priv->text_view;
	gtk_widget_set_margin_left ((GtkWidget*) _tmp11_, 8);
	_tmp12_ = self->priv->text_view;
	gtk_widget_set_margin_right ((GtkWidget*) _tmp12_, 8);
	_tmp13_ = self->priv->text_view;
	gtk_text_view_set_monospace (_tmp13_, TRUE);
	_tmp14_ = (GtkScrolledWindow*) gtk_scrolled_window_new (NULL, NULL);
	g_object_ref_sink (_tmp14_);
	_g_object_unref0 (self->priv->scroll);
	self->priv->scroll = _tmp14_;
	_tmp15_ = self->priv->scroll;
	gtk_scrolled_window_set_policy (_tmp15_, GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
	_tmp16_ = self->priv->scroll;
	_tmp17_ = self->priv->text_view;
	gtk_container_add ((GtkContainer*) _tmp16_, (GtkWidget*) _tmp17_);
	_tmp18_ = (GtkButton*) gtk_button_new_with_label ("Close");
	g_object_ref_sink (_tmp18_);
	btn_close = _tmp18_;
	g_signal_connect_object (btn_close, "clicked", (GCallback) _gtk_window_close_gtk_button_clicked, (GtkWindow*) self, 0);
	_tmp19_ = (GtkBox*) gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
	g_object_ref_sink (_tmp19_);
	vbox = _tmp19_;
	_tmp20_ = self->priv->scroll;
	gtk_box_pack_start (vbox, (GtkWidget*) _tmp20_, TRUE, TRUE, (guint) 0);
	gtk_box_pack_start (vbox, (GtkWidget*) btn_close, FALSE, FALSE, (guint) 0);
	gtk_container_add ((GtkContainer*) self, (GtkWidget*) vbox);
	_tmp21_ = tar_name;
	verify_window_verify (self, _tmp21_);
	_g_object_unref0 (vbox);
	_g_object_unref0 (btn_close);
	return self;
}


VerifyWindow* verify_window_new (const gchar* tar_name) {
	return verify_window_construct (TYPE_VERIFY_WINDOW, tar_name);
}


static gboolean ___lambda18_ (VerifyWindow* self, GIOChannel* channel, GIOCondition condition) {
	gboolean result = FALSE;
	GIOChannel* _tmp0_ = NULL;
	GIOCondition _tmp1_ = 0;
	gboolean _tmp2_ = FALSE;
	g_return_val_if_fail (channel != NULL, FALSE);
	_tmp0_ = channel;
	_tmp1_ = condition;
	_tmp2_ = verify_window_process_line (self, _tmp0_, _tmp1_, "stdout");
	result = _tmp2_;
	return result;
}


static gboolean ____lambda18__gio_func (GIOChannel* source, GIOCondition condition, gpointer self) {
	gboolean result;
	result = ___lambda18_ ((VerifyWindow*) self, source, condition);
	return result;
}


static gboolean ___lambda19_ (VerifyWindow* self, GIOChannel* channel, GIOCondition condition) {
	gboolean result = FALSE;
	GIOChannel* _tmp0_ = NULL;
	GIOCondition _tmp1_ = 0;
	gboolean _tmp2_ = FALSE;
	g_return_val_if_fail (channel != NULL, FALSE);
	_tmp0_ = channel;
	_tmp1_ = condition;
	_tmp2_ = verify_window_process_error (self, _tmp0_, _tmp1_, "stderr");
	result = _tmp2_;
	return result;
}


static gboolean ____lambda19__gio_func (GIOChannel* source, GIOCondition condition, gpointer self) {
	gboolean result;
	result = ___lambda19_ ((VerifyWindow*) self, source, condition);
	return result;
}


static void ___lambda20_ (VerifyWindow* self, GPid pid, gint status) {
	GPid _tmp0_ = 0;
	_tmp0_ = pid;
	g_spawn_close_pid (_tmp0_);
}


static void ____lambda20__gchild_watch_func (GPid pid, gint status, gpointer self) {
	___lambda20_ ((VerifyWindow*) self, pid, status);
}


static void verify_window_verify (VerifyWindow* self, const gchar* tar_name) {
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (tar_name != NULL);
	{
		gchar** spawn_args = NULL;
		gchar* _tmp0_ = NULL;
		gchar* _tmp1_ = NULL;
		const gchar* _tmp2_ = NULL;
		gchar* _tmp3_ = NULL;
		gchar* _tmp4_ = NULL;
		gchar** _tmp5_ = NULL;
		gint spawn_args_length1 = 0;
		gint _spawn_args_size_ = 0;
		gchar** spawn_env = NULL;
		gchar** _tmp6_ = NULL;
		gchar** _tmp7_ = NULL;
		gint spawn_env_length1 = 0;
		gint _spawn_env_size_ = 0;
		GPid child_pid = 0;
		gint standard_error = 0;
		gint standard_out = 0;
		GPid _tmp8_ = 0;
		gint _tmp9_ = 0;
		gint _tmp10_ = 0;
		GIOChannel* output = NULL;
		GIOChannel* _tmp11_ = NULL;
		GIOChannel* _tmp12_ = NULL;
		GIOChannel* _error_ = NULL;
		GIOChannel* _tmp13_ = NULL;
		GIOChannel* _tmp14_ = NULL;
		_tmp0_ = g_strdup ("tar");
		_tmp1_ = g_strdup ("tf");
		_tmp2_ = tar_name;
		_tmp3_ = g_strdup (_tmp2_);
		_tmp4_ = g_strdup ("--totals");
		_tmp5_ = g_new0 (gchar*, 4 + 1);
		_tmp5_[0] = _tmp0_;
		_tmp5_[1] = _tmp1_;
		_tmp5_[2] = _tmp3_;
		_tmp5_[3] = _tmp4_;
		spawn_args = _tmp5_;
		spawn_args_length1 = 4;
		_spawn_args_size_ = spawn_args_length1;
		_tmp7_ = _tmp6_ = g_get_environ ();
		spawn_env = _tmp7_;
		spawn_env_length1 = _vala_array_length (_tmp6_);
		_spawn_env_size_ = spawn_env_length1;
		g_spawn_async_with_pipes ("/", spawn_args, spawn_env, G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD, NULL, NULL, &_tmp8_, NULL, &_tmp9_, &_tmp10_, &_inner_error_);
		child_pid = _tmp8_;
		standard_out = _tmp9_;
		standard_error = _tmp10_;
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			spawn_env = (_vala_array_free (spawn_env, spawn_env_length1, (GDestroyNotify) g_free), NULL);
			spawn_args = (_vala_array_free (spawn_args, spawn_args_length1, (GDestroyNotify) g_free), NULL);
			if (_inner_error_->domain == G_SPAWN_ERROR) {
				goto __catch31_g_spawn_error;
			}
			spawn_env = (_vala_array_free (spawn_env, spawn_env_length1, (GDestroyNotify) g_free), NULL);
			spawn_args = (_vala_array_free (spawn_args, spawn_args_length1, (GDestroyNotify) g_free), NULL);
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
		_tmp11_ = g_io_channel_unix_new (standard_out);
		output = _tmp11_;
		_tmp12_ = output;
		g_io_add_watch (_tmp12_, G_IO_IN | G_IO_HUP, ____lambda18__gio_func, self);
		_tmp13_ = g_io_channel_unix_new (standard_error);
		_error_ = _tmp13_;
		_tmp14_ = _error_;
		g_io_add_watch (_tmp14_, G_IO_IN | G_IO_HUP, ____lambda19__gio_func, self);
		g_child_watch_add_full (G_PRIORITY_DEFAULT_IDLE, child_pid, ____lambda20__gchild_watch_func, g_object_ref (self), g_object_unref);
		_g_io_channel_unref0 (_error_);
		_g_io_channel_unref0 (output);
		spawn_env = (_vala_array_free (spawn_env, spawn_env_length1, (GDestroyNotify) g_free), NULL);
		spawn_args = (_vala_array_free (spawn_args, spawn_args_length1, (GDestroyNotify) g_free), NULL);
	}
	goto __finally31;
	__catch31_g_spawn_error:
	{
		GError* e = NULL;
		GtkTextView* _tmp15_ = NULL;
		GtkTextBuffer* _tmp16_ = NULL;
		GtkTextBuffer* _tmp17_ = NULL;
		GError* _tmp18_ = NULL;
		const gchar* _tmp19_ = NULL;
		gchar* _tmp20_ = NULL;
		gchar* _tmp21_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp15_ = self->priv->text_view;
		_tmp16_ = gtk_text_view_get_buffer (_tmp15_);
		_tmp17_ = _tmp16_;
		_tmp18_ = e;
		_tmp19_ = _tmp18_->message;
		_tmp20_ = g_strconcat ("Error calling tar: ", _tmp19_, NULL);
		_tmp21_ = _tmp20_;
		g_object_set (_tmp17_, "text", _tmp21_, NULL);
		_g_free0 (_tmp21_);
		_g_error_free0 (e);
	}
	__finally31:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return;
	}
}


static gboolean verify_window_process_line (VerifyWindow* self, GIOChannel* channel, GIOCondition condition, const gchar* stream_name) {
	gboolean result = FALSE;
	GIOCondition _tmp0_ = 0;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (self != NULL, FALSE);
	g_return_val_if_fail (channel != NULL, FALSE);
	g_return_val_if_fail (stream_name != NULL, FALSE);
	_tmp0_ = condition;
	if (_tmp0_ == G_IO_HUP) {
		GtkTextView* _tmp1_ = NULL;
		GtkTextBuffer* _tmp2_ = NULL;
		GtkTextBuffer* _tmp3_ = NULL;
		GtkTextView* _tmp4_ = NULL;
		GtkTextBuffer* _tmp5_ = NULL;
		GtkTextBuffer* _tmp6_ = NULL;
		gchar* _tmp7_ = NULL;
		gchar* _tmp8_ = NULL;
		gchar* _tmp9_ = NULL;
		gchar* _tmp10_ = NULL;
		gchar* _tmp11_ = NULL;
		GtkScrolledWindow* _tmp12_ = NULL;
		GtkAdjustment* _tmp13_ = NULL;
		GtkAdjustment* _tmp14_ = NULL;
		GtkScrolledWindow* _tmp15_ = NULL;
		GtkAdjustment* _tmp16_ = NULL;
		GtkAdjustment* _tmp17_ = NULL;
		gdouble _tmp18_ = 0.0;
		gdouble _tmp19_ = 0.0;
		GtkScrolledWindow* _tmp20_ = NULL;
		GtkAdjustment* _tmp21_ = NULL;
		GtkAdjustment* _tmp22_ = NULL;
		gdouble _tmp23_ = 0.0;
		gdouble _tmp24_ = 0.0;
		_tmp1_ = self->priv->text_view;
		_tmp2_ = gtk_text_view_get_buffer (_tmp1_);
		_tmp3_ = _tmp2_;
		_tmp4_ = self->priv->text_view;
		_tmp5_ = gtk_text_view_get_buffer (_tmp4_);
		_tmp6_ = _tmp5_;
		g_object_get (_tmp6_, "text", &_tmp7_, NULL);
		_tmp8_ = _tmp7_;
		_tmp9_ = _tmp8_;
		_tmp10_ = g_strconcat (_tmp9_, "\nDone. No errors found.", NULL);
		_tmp11_ = _tmp10_;
		g_object_set (_tmp6_, "text", _tmp11_, NULL);
		_g_free0 (_tmp11_);
		_g_free0 (_tmp9_);
		_tmp12_ = self->priv->scroll;
		_tmp13_ = gtk_scrolled_window_get_vadjustment (_tmp12_);
		_tmp14_ = _tmp13_;
		_tmp15_ = self->priv->scroll;
		_tmp16_ = gtk_scrolled_window_get_vadjustment (_tmp15_);
		_tmp17_ = _tmp16_;
		_tmp18_ = gtk_adjustment_get_upper (_tmp17_);
		_tmp19_ = _tmp18_;
		_tmp20_ = self->priv->scroll;
		_tmp21_ = gtk_scrolled_window_get_vadjustment (_tmp20_);
		_tmp22_ = _tmp21_;
		_tmp23_ = gtk_adjustment_get_page_size (_tmp22_);
		_tmp24_ = _tmp23_;
		gtk_adjustment_set_value (_tmp14_, _tmp19_ - _tmp24_);
		result = FALSE;
		return result;
	}
	{
		gchar* line = NULL;
		GIOChannel* _tmp25_ = NULL;
		gchar* _tmp26_ = NULL;
		GtkTextView* _tmp27_ = NULL;
		GtkTextBuffer* _tmp28_ = NULL;
		GtkTextBuffer* _tmp29_ = NULL;
		GtkTextView* _tmp30_ = NULL;
		GtkTextBuffer* _tmp31_ = NULL;
		GtkTextBuffer* _tmp32_ = NULL;
		gchar* _tmp33_ = NULL;
		gchar* _tmp34_ = NULL;
		gchar* _tmp35_ = NULL;
		const gchar* _tmp36_ = NULL;
		gchar* _tmp37_ = NULL;
		gchar* _tmp38_ = NULL;
		GtkScrolledWindow* _tmp39_ = NULL;
		GtkAdjustment* _tmp40_ = NULL;
		GtkAdjustment* _tmp41_ = NULL;
		GtkScrolledWindow* _tmp42_ = NULL;
		GtkAdjustment* _tmp43_ = NULL;
		GtkAdjustment* _tmp44_ = NULL;
		gdouble _tmp45_ = 0.0;
		gdouble _tmp46_ = 0.0;
		GtkScrolledWindow* _tmp47_ = NULL;
		GtkAdjustment* _tmp48_ = NULL;
		GtkAdjustment* _tmp49_ = NULL;
		gdouble _tmp50_ = 0.0;
		gdouble _tmp51_ = 0.0;
		_tmp25_ = channel;
		g_io_channel_read_line (_tmp25_, &_tmp26_, NULL, NULL, &_inner_error_);
		_g_free0 (line);
		line = _tmp26_;
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			_g_free0 (line);
			if (_inner_error_->domain == G_IO_CHANNEL_ERROR) {
				goto __catch32_g_io_channel_error;
			}
			if (_inner_error_->domain == G_CONVERT_ERROR) {
				goto __catch32_g_convert_error;
			}
			_g_free0 (line);
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return FALSE;
		}
		_tmp27_ = self->priv->text_view;
		_tmp28_ = gtk_text_view_get_buffer (_tmp27_);
		_tmp29_ = _tmp28_;
		_tmp30_ = self->priv->text_view;
		_tmp31_ = gtk_text_view_get_buffer (_tmp30_);
		_tmp32_ = _tmp31_;
		g_object_get (_tmp32_, "text", &_tmp33_, NULL);
		_tmp34_ = _tmp33_;
		_tmp35_ = _tmp34_;
		_tmp36_ = line;
		_tmp37_ = g_strconcat (_tmp35_, _tmp36_, NULL);
		_tmp38_ = _tmp37_;
		g_object_set (_tmp32_, "text", _tmp38_, NULL);
		_g_free0 (_tmp38_);
		_g_free0 (_tmp35_);
		_tmp39_ = self->priv->scroll;
		_tmp40_ = gtk_scrolled_window_get_vadjustment (_tmp39_);
		_tmp41_ = _tmp40_;
		_tmp42_ = self->priv->scroll;
		_tmp43_ = gtk_scrolled_window_get_vadjustment (_tmp42_);
		_tmp44_ = _tmp43_;
		_tmp45_ = gtk_adjustment_get_upper (_tmp44_);
		_tmp46_ = _tmp45_;
		_tmp47_ = self->priv->scroll;
		_tmp48_ = gtk_scrolled_window_get_vadjustment (_tmp47_);
		_tmp49_ = _tmp48_;
		_tmp50_ = gtk_adjustment_get_page_size (_tmp49_);
		_tmp51_ = _tmp50_;
		gtk_adjustment_set_value (_tmp41_, _tmp46_ - _tmp51_);
		_g_free0 (line);
	}
	goto __finally32;
	__catch32_g_io_channel_error:
	{
		GError* e = NULL;
		FILE* _tmp52_ = NULL;
		const gchar* _tmp53_ = NULL;
		GError* _tmp54_ = NULL;
		const gchar* _tmp55_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp52_ = stdout;
		_tmp53_ = stream_name;
		_tmp54_ = e;
		_tmp55_ = _tmp54_->message;
		fprintf (_tmp52_, "%s: IOChannelError: %s\n", _tmp53_, _tmp55_);
		result = FALSE;
		_g_error_free0 (e);
		return result;
	}
	goto __finally32;
	__catch32_g_convert_error:
	{
		GError* e = NULL;
		FILE* _tmp56_ = NULL;
		const gchar* _tmp57_ = NULL;
		GError* _tmp58_ = NULL;
		const gchar* _tmp59_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp56_ = stdout;
		_tmp57_ = stream_name;
		_tmp58_ = e;
		_tmp59_ = _tmp58_->message;
		fprintf (_tmp56_, "%s: ConvertError: %s\n", _tmp57_, _tmp59_);
		result = FALSE;
		_g_error_free0 (e);
		return result;
	}
	__finally32:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return FALSE;
	}
	result = TRUE;
	return result;
}


static gboolean verify_window_process_error (VerifyWindow* self, GIOChannel* channel, GIOCondition condition, const gchar* stream_name) {
	gboolean result = FALSE;
	GIOCondition _tmp0_ = 0;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (self != NULL, FALSE);
	g_return_val_if_fail (channel != NULL, FALSE);
	g_return_val_if_fail (stream_name != NULL, FALSE);
	_tmp0_ = condition;
	if (_tmp0_ == G_IO_HUP) {
		result = FALSE;
		return result;
	}
	{
		gchar* line = NULL;
		GIOChannel* _tmp1_ = NULL;
		gchar* _tmp2_ = NULL;
		GtkTextView* _tmp3_ = NULL;
		GtkTextBuffer* _tmp4_ = NULL;
		GtkTextBuffer* _tmp5_ = NULL;
		GtkTextView* _tmp6_ = NULL;
		GtkTextBuffer* _tmp7_ = NULL;
		GtkTextBuffer* _tmp8_ = NULL;
		gchar* _tmp9_ = NULL;
		gchar* _tmp10_ = NULL;
		gchar* _tmp11_ = NULL;
		const gchar* _tmp12_ = NULL;
		gchar* _tmp13_ = NULL;
		gchar* _tmp14_ = NULL;
		_tmp1_ = channel;
		g_io_channel_read_line (_tmp1_, &_tmp2_, NULL, NULL, &_inner_error_);
		_g_free0 (line);
		line = _tmp2_;
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			_g_free0 (line);
			if (_inner_error_->domain == G_IO_CHANNEL_ERROR) {
				goto __catch33_g_io_channel_error;
			}
			if (_inner_error_->domain == G_CONVERT_ERROR) {
				goto __catch33_g_convert_error;
			}
			_g_free0 (line);
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return FALSE;
		}
		_tmp3_ = self->priv->text_view;
		_tmp4_ = gtk_text_view_get_buffer (_tmp3_);
		_tmp5_ = _tmp4_;
		_tmp6_ = self->priv->text_view;
		_tmp7_ = gtk_text_view_get_buffer (_tmp6_);
		_tmp8_ = _tmp7_;
		g_object_get (_tmp8_, "text", &_tmp9_, NULL);
		_tmp10_ = _tmp9_;
		_tmp11_ = _tmp10_;
		_tmp12_ = line;
		_tmp13_ = g_strconcat (_tmp11_, _tmp12_, NULL);
		_tmp14_ = _tmp13_;
		g_object_set (_tmp8_, "text", _tmp14_, NULL);
		_g_free0 (_tmp14_);
		_g_free0 (_tmp11_);
		_g_free0 (line);
	}
	goto __finally33;
	__catch33_g_io_channel_error:
	{
		GError* e = NULL;
		FILE* _tmp15_ = NULL;
		const gchar* _tmp16_ = NULL;
		GError* _tmp17_ = NULL;
		const gchar* _tmp18_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp15_ = stdout;
		_tmp16_ = stream_name;
		_tmp17_ = e;
		_tmp18_ = _tmp17_->message;
		fprintf (_tmp15_, "%s: IOChannelError: %s\n", _tmp16_, _tmp18_);
		result = FALSE;
		_g_error_free0 (e);
		return result;
	}
	goto __finally33;
	__catch33_g_convert_error:
	{
		GError* e = NULL;
		FILE* _tmp19_ = NULL;
		const gchar* _tmp20_ = NULL;
		GError* _tmp21_ = NULL;
		const gchar* _tmp22_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp19_ = stdout;
		_tmp20_ = stream_name;
		_tmp21_ = e;
		_tmp22_ = _tmp21_->message;
		fprintf (_tmp19_, "%s: ConvertError: %s\n", _tmp20_, _tmp22_);
		result = FALSE;
		_g_error_free0 (e);
		return result;
	}
	__finally33:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return FALSE;
	}
	result = TRUE;
	return result;
}


static void verify_window_class_init (VerifyWindowClass * klass) {
	verify_window_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (VerifyWindowPrivate));
	G_OBJECT_CLASS (klass)->finalize = verify_window_finalize;
}


static void verify_window_instance_init (VerifyWindow * self) {
	self->priv = VERIFY_WINDOW_GET_PRIVATE (self);
}


static void verify_window_finalize (GObject* obj) {
	VerifyWindow * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TYPE_VERIFY_WINDOW, VerifyWindow);
	_g_object_unref0 (self->priv->text_view);
	_g_object_unref0 (self->priv->scroll);
	G_OBJECT_CLASS (verify_window_parent_class)->finalize (obj);
}


GType verify_window_get_type (void) {
	static volatile gsize verify_window_type_id__volatile = 0;
	if (g_once_init_enter (&verify_window_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (VerifyWindowClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) verify_window_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (VerifyWindow), 0, (GInstanceInitFunc) verify_window_instance_init, NULL };
		GType verify_window_type_id;
		verify_window_type_id = g_type_register_static (gtk_window_get_type (), "VerifyWindow", &g_define_type_info, 0);
		g_once_init_leave (&verify_window_type_id__volatile, verify_window_type_id);
	}
	return verify_window_type_id__volatile;
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	if ((array != NULL) && (destroy_func != NULL)) {
		int i;
		for (i = 0; i < array_length; i = i + 1) {
			if (((gpointer*) array)[i] != NULL) {
				destroy_func (((gpointer*) array)[i]);
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	_vala_array_destroy (array, array_length, destroy_func);
	g_free (array);
}


static gint _vala_array_length (gpointer array) {
	int length;
	length = 0;
	if (array) {
		while (((gpointer*) array)[length]) {
			length++;
		}
	}
	return length;
}



